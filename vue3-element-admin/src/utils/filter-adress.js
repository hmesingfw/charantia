export function FilterTokenAdress(val) {
    let adressList = [
        '/wx/weChart/sendCaptcha',
        '/auth/loginByplatform',
        '/auth/loginByCompany',
        '/sys/umsmember/queryMobile',
        '/sys/umsmember/queryCount',
        '/sys/umsmember/checkCaptchaFromRedis',
        '/sys/umsmember/updatePwdByMobile',
        '/sys/umscompany/register',
        '/sys/umscompany/queryCountByCode',
        '/sys/umscompany/queryCount'
    ];

    return adressList.some(item => {
        return val && val.indexOf(item) != -1
    })
}