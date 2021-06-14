git commit -am "dummy commit, in case I haven't"
git branch temp
git checkout temp
git merge temp -m "I fucked up the HEAD again :D"
git push
git branch -d temp
