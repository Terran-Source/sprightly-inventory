import {
  PrismaClient,
  Prisma,
  User as UserType,
  Post as PostType,
} from '../prisma-client';
import { dummyFaker, DataType } from 'dummy-faker';

const prisma = new PrismaClient();
const dummy = dummyFaker();
const User = Prisma.UserScalarFieldEnum;
const Post = Prisma.PostScalarFieldEnum;

enum UserRole {
  User = 'User',
  Admin = 'Admin',
}

let userModel = {
  [User.id]: DataType.int,
  [User.email]: DataType.string,
  [User.gender]: DataType.string,
  [User.name]: DataType.string,
  [User.bio]: DataType.string,
  [User.role]: DataType.string,
  [User.createdAt]: DataType.date,
  [User.updatedAt]: DataType.date,
};

let postModel = {
  [Post.id]: DataType.int,
  [Post.title]: DataType.string,
  [Post.authorId]: DataType.int,
  [Post.body]: DataType.string,
  [Post.published]: DataType.boolean,
  [Post.publishedAt]: DataType.date,
  [Post.createdAt]: DataType.date,
  [Post.updatedAt]: DataType.date,
};

dummy
  .register(Prisma.ModelName.User, userModel)
  .customize(Prisma.ModelName.User, (objFaker) => {
    objFaker.ruleFor(User.gender, (faker) => faker.name.gender(true));
    objFaker.ruleFor('fname', (faker, u) => faker.name.firstName(u.gender));
    objFaker.ruleFor('lname', (faker, u) => faker.name.lastName(u.gender));
    objFaker.ruleFor(User.email, (faker, u) =>
      faker.internet.email(u.fname, u.lname)
    );
    objFaker.ruleFor(User.name, (faker, u) =>
      faker.name.findName(u.fname, u.lname, u.gender)
    );
    objFaker.ruleFor(User.bio, (faker) => faker.lorem.paragraph());
    objFaker.ruleFor(User.role, (faker) =>
      faker.random.objectElement(UserRole, 'User')
    );
    objFaker.ruleFor(User.createdAt, (faker) => faker.date.past(2));
    objFaker.ruleFor(User.updatedAt, (faker, u) =>
      faker.date.between(u.createdAt, Date())
    );
  })
  .register(Prisma.ModelName.Post, postModel)
  .customize(Prisma.ModelName.Post, (objFaker, data) => {
    objFaker.ruleFor(Post.authorId, () => data.authorId);
    objFaker.ruleFor(Post.title, (faker) => faker.random.words());
    objFaker.ruleFor(Post.body, (faker) => faker.lorem.paragraphs());
    objFaker.ruleFor(Post.published, (faker) => faker.datatype.boolean());
    objFaker.ruleFor(Post.createdAt, (faker) => faker.date.past(2));
    objFaker.ruleFor(Post.updatedAt, (faker, u) =>
      faker.date.between(u.createdAt, Date())
    );
    objFaker.ruleFor(Post.publishedAt, (faker, u) =>
      u.published ? faker.date.between(u.createdAt, u.updatedAt) : null
    );
  });

const _cleanupUser = (user: UserType): UserType => {
  let result = {};
  Object.keys(userModel).forEach((k) => (result[k] = user[k]));
  return result as UserType;
};

(async () => {
  const users = await dummy.generate(Prisma.ModelName.User, 25);
  let posts = <any>[];
  for (const u in users) {
    const user = users[u];
    posts = [
      ...posts,
      ...(await dummy.generate(
        Prisma.ModelName.Post,
        dummy.faker.datatype.number(10),
        { authorId: user.id }
      )),
    ];
  }
  // console.info('users:', users);
  // console.info('posts:', posts);
  const creationJobs = [
    ...users.map((user) =>
      prisma.user
        .create({ data: _cleanupUser(user) })
        .then((u) => console.info('user created: ', u))
    ),
    ...posts.map((post) =>
      prisma.post
        .create({ data: post })
        .then((p) => console.info('post created: ', p))
    ),
  ];
  await Promise.all(creationJobs);
})();
