const cp = require('child_process');

const priv;
const username = process.env.GITHUB_USERNAME || 'codfish';

module.exports = {
  name: prompt('name', basename || package.name),
  version: '0.0.0-semantically-released',
  private: prompt('private', 'false', val => typeof val === 'boolean' ? val : !!val.match('true')),
  main: prompt('entry point', 'index.js'),
  repository: {
    type: 'git',
    url: `git://github.com/${username}/${basename}.git`,
  },
  bugs: { url: `https://github.com/${username}/${basename}/issues` },
  homepage: `https://github.com/${username}/${basename}`,
  keywords: prompt(s => s.split(/\s+/)),
  license: 'MIT',
  create: prompt('create github repo', 'yes', val => {
    if (val[0] !== 'y') return;

    console.log('enter github password:');
    cp.execSync(`curl -u ${username} https://api.github.com/user/repos -d ` +
      `{ "name": "${basename}", "private": "${priv ? 'true' : 'false'}" }`);
    cp.execSync(`git remote add origin https://github.com/${username}/${basename}.git`);
  }),
};
