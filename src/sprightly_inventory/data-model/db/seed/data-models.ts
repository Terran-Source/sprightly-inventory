import {
  Prisma,
  PrismaClient,
  User as UserType,
  Post as PostType,
} from '../prisma-client';
import { dummyFaker, DataType } from 'dummy-faker';

export { type UserType, type PostType };

export const prisma = new PrismaClient();
export const dummy = dummyFaker();
export const User = Prisma.UserScalarFieldEnum;
export const Post = Prisma.PostScalarFieldEnum;

let userId = 1;
let postId = 1;

export enum UserRole {
  User = 'User',
  Admin = 'Admin',
}

export let userModel = {
  [User.id]: DataType.string,
  [User.email]: DataType.string,
  [User.gender]: DataType.string,
  [User.name]: DataType.string,
  [User.bio]: DataType.string,
  [User.role]: DataType.string,
  [User.createdAt]: DataType.date,
  [User.updatedAt]: DataType.date,
};

export let postModel = {
  [Post.id]: DataType.string,
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
      .ruleFor(User.id, async () => '' + userId++)
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
      .ruleFor(Post.id, async () => '' + postId++)
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

export const cleanupUser = (user: UserType): UserType => {
  let result = {};
  Object.keys(userModel).forEach((k) => (result[k] = user[k]));
  return result as UserType;
};
