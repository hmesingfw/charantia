'use strict';

class SysUtils {
    UUID() {
        const datatime = new Date().getTime();
        const time = datatime + '' + datatime + datatime;
        return time.substring(0, 32);
    }

    getTree(arrayList, parentid, returnArr) {
        if (arrayList && arrayList.length > 0) {
            arrayList.forEach(arr => {
                if (arr.parentid == parentid) {

                    let reArr = [];
                    this.getTree(arrayList, arr.id, reArr);
                    arr.children = reArr;
                    returnArr.push(arr);
                    // arrayList.splice(i, 1);
                }
            });
        }
    }
}

module.exports = SysUtils;
