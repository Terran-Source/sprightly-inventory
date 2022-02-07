import { Prisma } from '../prisma-client';
import { prisma, cleanupUser, dummy, PostType, UserType } from './data-models';
import { AbortController } from 'node-abort-controller';
import pRetry, { Options as RetryOptions } from 'p-retry';

const ac = new AbortController();
const retryOptions: RetryOptions = {
  retries: 5,
  factor: 2,
  minTimeout: 10,
  maxTimeout: 10 * 1000,
  randomize: true,
};

let userCount = 0;
let postCount = 0;

const _handleUserPostCreation = async (user: UserType): Promise<void> => {
  // console.info('got user..', user.email);
  const createdUser = await pRetry(
    () => prisma.user.create({ data: user }),
    retryOptions
  );
  // console.info('user created: ', createdUser.id, createdUser.email);

  const postReader = dummy.generateStream(
    Prisma.ModelName.Post,
    dummy.faker.datatype.number(5),
    { authorId: createdUser.id },
    { signal: ac.signal }
  );
  postReader
    .on('data', (post: PostType) => {
      postCount++;
      pRetry(() => prisma.post.create({ data: post }), retryOptions);
      // .then((p) => console.info('post created: ', p.id));
    })
    .on('end', () => {
      console.info(
        `completed streaming posts for user: ${createdUser.id}...`,
        postCount
      );
    })
    .on('error', (err) => {
      ac.abort();
      console.error(err);
    });
};

(async () => {
  const userReader = dummy.generateStream(Prisma.ModelName.User, 1000, null, {
    signal: ac.signal,
  });

  userReader
    .on('data', (user) => {
      userCount++;
      _handleUserPostCreation(cleanupUser(user));
    })
    .on('end', () => {
      console.info('completed streaming all users...', userCount);
    })
    .on('error', (err) => {
      ac.abort();
      console.error(err);
    });
})();
