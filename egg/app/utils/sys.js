'use strict';

class SysUtils {
    UUID() {
        const datatime = new Date().getTime();
        const time = datatime + '' + datatime + datatime;
        return time.substring(0, 32);
    }
}

module.exports = SysUtils;

