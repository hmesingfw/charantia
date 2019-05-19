'use strict';

class SysUtils {

    constructor() {
        this.getTree = this.getTree.bind(this); // this 指向
    }

    UUID() {
        const datatime = new Date().getTime();
        const time = datatime + '' + datatime + datatime;
        return time.substring(0, 32);
    }

    getTree(arrayList, id) {
        let obj = [];
        if (arrayList && arrayList.length > 0) {
            for (let i = 0; i < arrayList.length; i++) {
                let arr = arrayList[i];

                if (arr.parentid == id) {

                    let reArr = this.getTree(arrayList, arr.id);

                    if (reArr && reArr.length > 0) {
                        let obj2 = JSON.parse(JSON.stringify(arr)); // 深拷贝常用方法

                        let children = {
                            children: reArr
                        };
                        let boarr = {
                            ...obj2,
                            ...children
                        };
                        obj.push(boarr);
                    } else {
                        obj.push(arr);
                    }
                    // arrayList.splice(i, 1);
                }
            }
        }
        return obj;
    }
}

module.exports = SysUtils;
