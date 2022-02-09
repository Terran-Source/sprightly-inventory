import { Prisma } from '../prisma-client';
import { prisma, cleanupUser, dummy, PostType, UserType } from './data-models';

(async () => {
  const users: UserType[] = await dummy.generate(Prisma.ModelName.User, 100);
  let posts: PostType[] = [];
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
        .create({ data: cleanupUser(user) })
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
