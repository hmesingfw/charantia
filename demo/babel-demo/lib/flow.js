"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

/*按钮权限配置对象*/
var permissionData = {
  permission: ['search', 'add', 'update', 'delete']
};
new Vue({
  el: '#app',
  data: function data() {
    return {
      serviceType: [],
      //业务类型
      //遇忙、排队处理方式
      iBusyOverflowTyepEnum: [{
        id: "0",
        text: "不指定"
      }, {
        id: "1",
        text: "释放"
      }],
      //流程文件格式
      iFlowFormatEnum: [{
        id: "0",
        text: "不指定"
      }, {
        id: "1",
        text: "DOC"
      }, {
        id: "2",
        text: "XLS"
      }, {
        id: "3",
        text: "PPT"
      }, {
        id: "4",
        text: "JPG"
      }, {
        id: "5",
        text: "PNG"
      }, {
        id: "6",
        text: "TXT"
      }],
      //转接类型
      iTransferTypeEnum: [{
        id: "0",
        text: "不指定"
      }, {
        id: "1",
        text: "技能队列"
      }],
      tableData: [],
      //列表数据
      loading: false,
      //加载条
      searchForm: {
        //查询条件
        pageNo: 1,
        //当前页
        pageSize: 5 //每页记录数

      },
      totalCount: 0,
      //总记录数
      pageSizes: [5, 10, 15, 20, 25],
      activeNames: ['1'],
      //折叠面板
      dialogFormVisible: false,
      //dialog开窗控制
      editForm: {
        //人员编辑数据
        iFlowId: null,
        iStartType: '0',
        iBusyOverflowTyep: '0',
        iLoadState: '0',
        iHelpFlag: '0',
        iLocalIvrFlag: '0',
        iFlowFormat: '0',
        iTransferType: '0'
      },
      isIVREnum: {
        '0': '否',
        '1': '是'
      },
      //是否本地ivr枚举
      iStartTypeEnum: {
        '0': '非自启动',
        '1': '自启动'
      },
      rules: {
        //验证规则
        sFlowName: {
          required: true,
          message: '请输入流程描述',
          trigger: 'blur'
        },
        iStartTime: {
          required: true,
          message: '请输入自启动时间',
          trigger: 'blur'
        },
        iTypeId: {
          required: true,
          message: '请输入流程业务类型',
          trigger: 'blur'
        },
        iFlowInsert: {
          required: true,
          message: '请输入流程接入码',
          trigger: 'blur'
        },
        sFlowPath: {
          required: true,
          message: '请输入流程文件名',
          trigger: 'blur'
        }
      },
      currentRow: null,
      //当前行选行
      listHei: 390,
      //列表高度
      collapseHei: 0,
      //折叠面板内容高度
      dialogTitle: '' //开窗标题

    };
  },
  methods: {
    /**
     * 加载业务类型
     */
    loadServiceType: function loadServiceType() {
      var _this2 = this;

      var _this = this;

      var url = 'tIvsVdnFlow/serviceTypeList';
      this.$axios({
        method: 'post',
        url: url,
        data: {},
        success: function success(resp) {
          var _resp$data = resp.data,
              code = _resp$data.code,
              message = _resp$data.message,
              data = _resp$data.data;
          _this.serviceType = resp.data.data;
        },
        error: function error(_error) {
          _this2.$message.error(_error);
        }
      });
    },

    /**
     * 查询列表数据
     */
    doSearch: function doSearch() {
      var _this = this;

      _this.loading = true;
      var url = 'tIvsVdnFlow/list';
      var date = _this.dateVal;

      _this.$axios({
        method: 'post',
        url: url,
        data: _this.searchForm,
        success: function success(resp) {
          _this.loading = false;
          var _resp$data2 = resp.data,
              code = _resp$data2.code,
              message = _resp$data2.message,
              data = _resp$data2.data;

          if (code !== 200) {
            _this.$message.error(message);
          } else {
            _this.tableData = data.records;
            _this.totalCount = parseInt(data.total);
          }

          _this.setListHei();
        },
        error: function error(_error2) {
          _this.$message.error(_error2);

          _this.loading = false;
        }
      });
    },

    /**
     * 折叠面板change事件
     */
    handleChange: function handleChange(val) {
      if (val.length > 0) {
        //展开
        this.listHei -= this.collapseHei;
      } else {
        this.collapseHei = document.getElementsByClassName('el-collapse-item__wrap')[0].offsetHeight;
        this.listHei += this.collapseHei;
      }
    },

    /**
     * 是否ivr格式化
     */
    isIVRFormatter: function isIVRFormatter(row, column, cellValue, index) {
      row.iLocalIvrFlag += ''; //数字不行,只能字符串

      return this.isIVREnum[cellValue];
    },

    /**
     * 启动类型格式化
     */
    iStartTypeFormatter: function iStartTypeFormatter(row, column, cellValue, index) {
      row.iStartType += ''; //数字不行,只能字符串

      return this.iStartTypeEnum[cellValue];
    },

    /**
     * 业务类型格式化
     */
    serviceTypeFormatter: function serviceTypeFormatter(row, column, cellValue, index) {
      var result = '';
      this.serviceType.forEach(function (item) {
        if (item.id == cellValue) {
          result = item.text;
        }
      });
      return result;
    },

    /**
     * 每页条数change事件
     */
    handleSizeChange: function handleSizeChange(val) {
      this.searchForm.pageSize = val;
      this.doSearch();
    },

    /**
     * 前往第n页change事件
     */
    handleCurrentChange: function handleCurrentChange(val) {
      this.searchForm.pageNo = val;
      this.doSearch();
    },

    /**
     * 删除功能
     */
    doDelete: function doDelete() {
      var _this = this;

      var selections = _this.$refs.multipleTable.selection;
      var len = selections.length;

      if (len == 0) {
        _this.$message.warning("请勾选数据!");

        return;
      }

      var ids = [];

      for (var i = 0; i < len; i++) {
        ids.push(selections[i].iFlowId);
      }

      _this.$confirm('此操作将永久删除选中的数据, 是否继续?', '删除', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function () {
        _this.$axios({
          method: 'post',
          url: 'tIvsVdnFlow/delete',
          data: Qs.stringify({
            ids: ids.join(',')
          }),
          success: function success(resp) {
            var _resp$data3 = resp.data,
                code = _resp$data3.code,
                message = _resp$data3.message,
                data = _resp$data3.data;

            if (code !== 200) {
              _this.$message.error(message);
            } else {
              _this.$message.success("删除成功");

              _this.doSearch();
            }
          },
          error: function error(_error3) {
            _this.$message.error(_error3);
          }
        });
      }).catch(function () {
        _this.$message({
          type: 'info',
          message: '取消删除'
        });
      });
    },

    /**
     * 新增功能
     */
    doAdd: function doAdd() {
      this.cancel();
      this.dialogTitle = '新增';
      this.dialogFormVisible = true;
    },

    /**
     * 修改功能
     */
    doUpdate: function doUpdate() {
      var _this = this;

      var selections = _this.$refs.multipleTable.selection;
      var len = selections.length;

      if (len > 1) {
        _this.$message.warning("只能勾选一个数据");

        return;
      }

      var selection = selections[0];

      if (selection) {
        _this.editForm = _this.deepCopy(selection);
      } else if (_this.currentRow && !selection) {
        _this.editForm = _this.deepCopy(_this.currentRow);
      } else {
        _this.$message.warning("请选择要修改的数据!");

        return;
      } //下拉列表数字不行,只能字符串


      _this.editForm.iLoadState = _this.editForm.iLoadState + "";
      _this.editForm.iHelpFlag = _this.editForm.iHelpFlag + "";
      _this.editForm.iFlowFormat = _this.editForm.iFlowFormat + "" ? _this.editForm.iFlowFormat + "" : "";
      _this.editForm.iBusyOverflowTyep = _this.editForm.iBusyOverflowTyep + "" ? _this.editForm.iBusyOverflowTyep + "" : "";
      _this.editForm.iTransferType = _this.editForm.iTransferType + "" ? _this.editForm.iTransferType + "" : "";
      this.dialogTitle = '修改';
      _this.dialogFormVisible = true;
    },

    /**
     * 对象复制
     */
    deepCopy: function deepCopy(obj) {
      var result = Array.isArray(obj) ? [] : {};

      for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
          if (obj[key] && _typeof(obj[key]) === "object") {
            result[key] = this.deepCopy(obj[key]); //递归复制
          } else {
            result[key] = obj[key];
          }
        }
      }

      return result;
    },

    /**
     * 行选行事件
     */
    handleCurrentRow: function handleCurrentRow(val) {
      this.currentRow = val;
    },

    /**
     * 取消
     */
    cancel: function cancel() {
      this.editForm = {
        iFlowId: null,
        iStartType: '0',
        iBusyOverflowTyep: '0',
        iLoadState: '0',
        iHelpFlag: '0',
        iLocalIvrFlag: '0',
        iFlowFormat: '0',
        iTransferType: '0'
      };
      if (this.$refs['editForm']) this.$refs['editForm'].resetFields();
      this.dialogFormVisible = false;
    },

    /**
     * 保存
     */
    save: function save() {
      var _this = this;

      _this.$refs.editForm.validate(function (valid) {
        if (valid) {
          var resturl = 'tIvsVdnFlow/save';
          if (_this.editForm.iFlowId != null && _this.editForm.iFlowId != '') resturl = 'tIvsVdnFlow/update';

          _this.$axios({
            method: 'post',
            url: resturl,
            data: _this.editForm,
            success: function success(resp) {
              _this.cancel();

              var _resp$data4 = resp.data,
                  code = _resp$data4.code,
                  message = _resp$data4.message,
                  data = _resp$data4.data;

              if (code !== 200) {
                _this.$message.error(message);
              } else {
                _this.$message.success("保存成功");

                _this.doSearch();
              }
            },
            error: function error(_error4) {
              _this.$message.error(_error4);
            }
          });
        } else {
          return false;
        }
      });
    },

    /**
     * 自适应
     */
    setWH: function setWH() {
      var _this = this;

      window.onresize = function () {
        return function () {
          _this.setListHei();
        }();
      };
    },

    /**
     * 计算列表高度
     */
    setListHei: function setListHei() {
      this.listHei = document.body.clientHeight - document.getElementsByClassName('el-collapse')[0].clientHeight - document.getElementsByClassName('row-button')[0].clientHeight - document.getElementsByClassName('row-pagination')[0].clientHeight - 55;
    },
    doImport: function doImport() {
      this.$message.success('导入');
    },
    doExport: function doExport() {
      this.$message.success('导出');
    }
  },
  mounted: function mounted() {
    this.loadServiceType();
    this.doSearch();
    this.setWH();
  }
});