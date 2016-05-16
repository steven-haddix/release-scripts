#!/usr/bin/env node

/*
Takes in a tag version and updates the patch level and passes that back.
Example: v1.2.0 -> v1.2.1

Arg1: version tag
*/

//grab input
var tagVersion = process.argv[2];
//sanity check
if(!tagVersion || !tagVersion.match(/^[v]?\d+\.\d+\.\d+$/)) {
	console.log("You must provide a tag that matches the correct version. Ex. v2.0.0 or 2.0.0");
	process.exit(-1);
}

//increment patch level
var newTagVersion = tagVersion.replace(/(\d+)\.\d+$/, function(match, minorVersion ) {
	return (parseInt(minorVersion) + 1).toString() + ".0";
});

console.log(newTagVersion);
