wget http://static.keep.moe/Crystal.py
python Crystal.py generate https://github.com/SumiMakito/SumiMakito.github.io.git ./
cd /tmp/crystal_tmp/dist
git config --global user.email "sumimaito@hotmail.com"
git config --global user.name "SumiMakito"
git push --quiet https://${GitHubKEY}@github.com/SumiMakito/SumiMakito.github.io.git
