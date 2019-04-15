PUBLIC="/path/to/public/Public"
D8ROOT="d8"
echo "*********************"
echo "*********************"
echo ""
echo ""
echo "This script execute a Drupal update defined at"
echo "https://www.drupal.org/docs/8/update/update-core-manually"
echo ""
echo ""
echo "Before you proceed you understand that:"
echo " * you use this script at your own risk"
echo " * you made filesystem backup"
echo " * you made database(s) backup"
echo ""
echo ""
read -p "Are you ready to update to latest Drupal. Type \"Y\" to confirm, please?" -n 1 -r
echo "*********************"
echo "TODO:"
echo " *  set offline subdomains "
echo " *  create link  "
echo "*********************"

if [[ $REPLY =~ ^[Yy]$ ]]
  then
    cd $PUBLIC

    #A. clean
    rm -Rfv  *tar.gz*
    rm -Rfv drupal-latest

    #B. get
    wget https://www.drupal.org/download-latest/tar.gz
    tar -zxvf tar.gz

    #C. prepare
    mkdir drupal-latest && tar xf tar.gz  -C drupal-latest  --strip-components 1

    #D. execute
    cd $D8ROOT
    cp -Rfv ../drupal-latest/*php .
    cp -Rfv ../drupal-latest/.ht* .
    cp -Rfv ../drupal-latest/profiles/ .
    cp -Rfv ../drupal-latest/themes/ .
    cp -Rfv ../drupal-latest/robots.txt  .
    cp -Rfv ../drupal-latest/vendor/ .
    cp -Rfv ../drupal-latest/core/ .
    cp -Rfv ../drupal-latest/modules/ .
    cp -Rfv ../drupal-latest/sites/ .
    cp -Rfv ../drupal-latest/*config .

    echo "*************************************************"
    echo "Done, you should now have the very latest Drupal"
    echo "Check your update process here https://your-site/admin/reports/updates"
    echo "Update your database: https://your-site/update.php"
    echo "*************************************************"
fi
echo "End of script"
