var fs = require('fs');
var path = require('path');

var imgFilePath = path.resolve('../assets');
var outputFilePath = path.resolve('./image.txt');
var imgPathPrefix = '- assets/';

initImagePath(imgFilePath);

function initImagePath(rootPath) {
  fs.readdir(rootPath, function (err, files) {
    let imagePathTxt = '';

    files.forEach(function (filename) {
      imagePathTxt += `${imgPathPrefix}${filename} \n`;
    });

    writeImagePath(outputFilePath, imagePathTxt);
  });
}

function writeImagePath(txtFilePath, context) {
  fs.writeFile(txtFilePath, context, {}, function (err) {
    console.log('err', err);
  });
}
