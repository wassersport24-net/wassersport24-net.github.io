#!/bin/bash

category="$1"
database="$2"
newdomain="$3"



if [ $# -ne 4 ]
  then
    echo "No arguments supplied"
    echo "Usage: $0 category database newdomain"
fi

echo "Provided data: category $1, database: $2, newdomain $3"

echo "Proceed? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]
  then
    echo "Alright. Proceeding..."
  else
    exit
fi




activate () {
  . /home/kempo/git/tools/structured-data-bot/venv/bin/activate
}

rsync -avz --exclude docs/ --exclude node_modules --exclude template/ --exclude .git/ /home/kempo/git/templates/nuxt-seo-template/ /home/kempo/git/$newdomain/ &&

activate && 

python /home/kempo/git/tools/structured-data-bot/globetrotter-de-outdoorhosen.py -c $category -gc -gp -gb -db $database -of $newdomain -di && 

cp -r /home/kempo/git/tools/structured-data-bot/data/$newdomain/images /home/kempo/git/$newdomain/static/assets/images/ &&

cp -r /home/kempo/git/tools/structured-data-bot/data/$newdomain/*.json /home/kempo/git/$newdomain/assets/data/ && 

cd /home/kempo/git/$newdomain/ && npm install && npm run dev

