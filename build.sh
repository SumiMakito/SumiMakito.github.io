hexo generate
cd ./public
git init
git config --global push.default matching
git config --global user.email "sumimakito@hotmail.com"
git config --global user.name "SumiMakito"
git add --all .
git commit -m "Travis CI Auto Builder"
git push --quiet --force https://${GitHubKEY}@github.com/SumiMakito/SumiMakito.github.io.git master
