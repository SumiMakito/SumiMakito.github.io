wget http://static.keep.moe/Crystal.py
python Crystal.py generate https://github.com/SumiMakito/SumiMakito.github.io.git ./
cp -rf /tmp/crystal_tmp/dist/* ./
git init
git config --global push.default matching
git config --global user.email "sumimaito@hotmail.com"
git config --global user.name "SumiMakito"
git add --all .
git commit -m "Crystal Auto Builder"
git push --force https://${GitHubKEY}@github.com/SumiMakito/SumiMakito.github.io.git raw:master

