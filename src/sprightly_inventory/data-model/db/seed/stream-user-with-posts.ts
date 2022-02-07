import {
  PrismaClient,
  Prisma,
  User as UserType,
  Post as PostType,
} from '../prisma-client';
import { dummyFaker, DataType } from 'dummy-faker';
import { AbortController } from 'node-abort-controller';

const prisma = new PrismaClient();
const dummy = dummyFaker();
const User = Prisma.UserScalarFieldEnum;
const Post = Prisma.PostScalarFieldEnum;
const ac = new AbortController();

let userId = 1;
let postId = 1;

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
    objFaker
      .ruleFor(User.id, async () => userId++)
      .ruleFor(User.gender, (faker) => faker.name.gender(true))
      .ruleFor('fname', (faker, u) => faker.name.firstName(u.gender))
      .ruleFor('lname', (faker, u) => faker.name.lastName(u.gender))
      .ruleFor(User.email, (faker, u) => faker.internet.email(u.fname, u.lname))
      .ruleFor(User.name, (faker, u) =>
        faker.name.findName(u.fname, u.lname, u.gender)
      )
      .ruleFor(User.bio, (faker) => faker.lorem.paragraph())
      .ruleFor(User.role, (faker) =>
        faker.random.objectElement(UserRole, 'User')
      )
      .ruleFor(User.createdAt, (faker) => faker.date.past(2))
      .ruleFor(User.updatedAt, (faker, u) =>
        faker.date.between(u.createdAt, Date())
      );
  })
  .register(Prisma.ModelName.Post, postModel)
  .customize(Prisma.ModelName.Post, (objFaker, data) => {
    objFaker
      .ruleFor(Post.id, async () => postId++)
      .ruleFor(Post.authorId, () => data.authorId)
      .ruleFor(Post.title, (faker) => faker.random.words())
      .ruleFor(Post.body, (faker) => faker.lorem.paragraphs())
      .ruleFor(Post.published, (faker) => faker.datatype.boolean())
      .ruleFor(Post.createdAt, (faker) => faker.date.past(2))
      .ruleFor(Post.updatedAt, (faker, u) =>
        faker.date.between(u.createdAt, Date())
      )
      .ruleFor(Post.publishedAt, (faker, u) =>
        u.published ? faker.date.between(u.createdAt, u.updatedAt) : null
      );
  });

const _cleanupUser = (user: UserType): UserType => {
  let result = {};
  Object.keys(userModel).forEach((k) => (result[k] = user[k]));
  return result as UserType;
};

const _handleUserPostCreation = async (user: UserType): Promise<void> => {
  console.info('got user..', user.id);
  const createdUser = await prisma.user.create({ data: user });
  console.info('user created: ', createdUser.id, user.email);

  const postReader = dummy.generateStream(
    Prisma.ModelName.Post,
    dummy.faker.datatype.number(10),
    { authorId: createdUser.id },
    { signal: ac.signal }
  );
  postReader
    .on('data', (post: PostType) => {
      prisma.post
        .create({ data: post })
        .then((p) => console.info('post created: ', p.id));
    })
    .on('end', () => {
      console.info(`completed streaming posts for user: ${user.id}...`);
    })
    .on('error', (err) => {
      ac.abort();
      console.error(err);
    });
};

(async () => {
  const userReader = dummy.generateStream(Prisma.ModelName.User, 100, null, {
    signal: ac.signal,
  });
  userReader
    .on('data', (user) => {
      _handleUserPostCreation(_cleanupUser(user));
    })
    .on('end', () => {
      console.info('completed streaming all users...');
    })
    .on('error', (err) => {
      ac.abort();
      console.error(err);
    });
})();
