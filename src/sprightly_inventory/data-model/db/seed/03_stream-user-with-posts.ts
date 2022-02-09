import { Prisma } from '../prisma-client';
import { prisma, cleanupUser, dummy, PostType, UserType } from './data-models';
import { AbortController } from 'node-abort-controller';

const ac = new AbortController();

const _handleUserPostCreation = async (user: UserType): Promise<void> => {
  console.info('got user..', user.id);
  const createdUser = await prisma.user.create({ data: user });
  console.info('user created: ', createdUser.id, createdUser.email);

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
      console.info(`completed streaming posts for user: ${createdUser.id}...`);
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
      _handleUserPostCreation(cleanupUser(user));
    })
    .on('end', () => {
      console.info('completed streaming all users...');
    })
    .on('error', (err) => {
      ac.abort();
      console.error(err);
    });
})();
