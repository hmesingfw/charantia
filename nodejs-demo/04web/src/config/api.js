const baseURL = process.env.VUE_APP_URL;
const imageType = '.jpg, .jpeg, .gif, .bmp';
const baseURL135 = 'http://192.168.31.135:8081';
export default {
    /* 系统管理 */
    sys: {
        sysuserList: baseURL + '/sys/sysuser/selectList',   //人员信息 - 列表

        sysuser: baseURL + '/sys/sysuser',   //人员信息 -新增，修改 ，删除
        sysusersetpwd: baseURL + '/sys/sysuser/updatePwd', // 重置密码

        queryUserRole: baseURL + '/sys/sysrole/queryByUserId',   //查询用户下的角色
        sysuserrole: baseURL + '/sys/sysuserrole',   //给用户分配角色

        syspermissionList: baseURL + '/sys/syspermission/selectList',   //角色信息 - 菜单 -列表
        syspermission: baseURL + '/sys/syspermission',   //角色信息 - 菜单 -新增，修改 ，删除

        sysroleList: baseURL + '/sys/sysrole/selectList',   //角色信息 - 列表
        sysrole: baseURL + '/sys/sysrole',   //角色信息 - 菜单 -新增，修改 ，删除

        queryRolePermission: baseURL + '/sys/syspermission/queryByRoleId',   //角色信息 - 查询权限
        sysrolepermission: baseURL + '/sys/sysrolepermission',   //角色信息 - 查询权限 



        doctor: baseURL + '/api/v1/doctor',      //医生信息
        options: baseURL + '/api/v1/options',       // 静态数据信息
        option: baseURL + '/api/v1/option',       // 静态数据信息

        notices: baseURL + '/api/v1/notices',       // 重要事项
        notice: baseURL + '/api/v1/notice',       //  重要事项

        nurseItems: baseURL + '/api/v1/nurseItems',       // 项目信息
        nurseItem: baseURL + '/api/v1/nurseItem',       //  项目信息

        nursing: baseURL + '/api/v1/nursing',       //..根据病人查询所关联的项目  传sickId  反之传 nurseId

        nurse: baseURL + '/api/v1/nurse',       //  项目病人信息

        patients: baseURL + '/api/v1/patients',       // 查询病人信息
        patient: baseURL + '/api/v1/patient',       // 
        patientItem: baseURL + '/api/v1/nurse/item',   //病人添加多个看护项目

        sickbeds: baseURL + '/api/v1/sickbeds',       // 病床信息
        sickbed: baseURL + '/api/v1/sickbed',       // 病床信息

        checkIn: baseURL + '/api/v1/hospital/checkIn',    // 入院
        leave: baseURL + '/api/v1/hospital/leave',    // 出院



    },
    /* 平台登录  */
    user: {
        login: baseURL + '/auth/loginByplatform',   // 登录接口
        queryButtonByPId: baseURL + '/sys/syspermission/queryButtonByPId',   // 用户获取按钮权限信息
        updatePwd: baseURL + '/sys/sysuser/updatePwd', // 修改密码
        mobeliupdatePwd: baseURL + '/sys/umsmember/updatePwdByMobile', // 手机号码修改密码

        getPricuteCode: baseURL + '/auth/getPricuteCode',           // 图片验证码
    },
    imageType,


}