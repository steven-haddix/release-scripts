/*
 Loads up the package.json file, and upadates the common-web dependecy.
 Arg1: path to package.json file
 Arg2: path to new common-web
 */

var fs = require('fs');

//load json file (from args)
var packageFile;
var fileName = process.argv[2];
fs.readFile(fileName, 'utf8', function (error, data) {
    if (error) {
        console.log(error);
        process.exit(-1);
    }
    packageFile = JSON.parse(data);

    //update file to correct release (get from args)
    packageFile.dependencies['common-web'] = process.argv[3];

    //save file
    fs.writeFile(fileName, JSON.stringify(packageFile, null, 2), 'utf8', function () {
        process.exit();
    });

});
