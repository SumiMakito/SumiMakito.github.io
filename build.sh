wget http://static.keep.moe/Crystal.py
python Crystal.py build https://github.com/SumiMakito/SumiMakito.github.io.git --output=./
#find
#cp -rf /tmp/crystal_tmp/dist/* ./
cd ./crystal_dist
rm -rf ./.git
git init
git config --global push.default matching
git config --global user.email "sumimaito@hotmail.com"
git config --global user.name "SumiMakito"
git add --all .
git commit -m "Crystal Auto Builder"
git push --quiet --force https://${GitHubKEY}@github.com/SumiMakito/SumiMakito.github.io.git master

