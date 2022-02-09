import { Prisma } from '../prisma-client';
import {
  prisma,
  cleanupUser,
  dummy,
  Post,
  PostType,
  UserType,
} from './data-models';

const _handleUserPostCreation = async (user: UserType): Promise<UserType> => {
  const posts: PostType[] = await dummy.generate(
    Prisma.ModelName.Post,
    dummy.faker.datatype.number(10),
    null,
    { skip: [Post.authorId] }
  );
  const userCreation = Object.assign({}, user, {
    Posts: {
      create: posts,
    },
  });
  console.info('userCreation: ', userCreation);
  return prisma.user.create({ data: userCreation });
};

(async () => {
  const users: UserType[] = await dummy.generate(Prisma.ModelName.User, 100);
  const creationJobs = users.map((user) =>
    _handleUserPostCreation(cleanupUser(user)).then((u) =>
      console.info('user & post created')
    )
  );
  await Promise.all(creationJobs);
})();
