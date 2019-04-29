"use strict";

new Vue({
  el: '#app',
  data: function data() {
    return {
      filterText: '',
      iframeUrl: "/callcenter/vdn/essentialInformation/essentialInformation.html",
      iframeWidth: 0,
      iframeHeight: 0,
      data: [{
        id: 1,
        label: '基本信息',
        url: "/callcenter/vdn/essentialInformation/essentialInformation.html"
      }, {
        id: 2,
        label: '业务类型',
        url: "/callcenter/vdn/serviceType/serviceType.html"
      }, {
        id: 3,
        label: '技能',
        children: [{
          id: 4,
          label: '技能队列',
          url: "/callcenter/vdn/skills/skillLined.html"
        }, {
          id: 5,
          label: '技能组',
          url: "/callcenter/vdn/skillGroup/skillGroup.html"
        }]
      }, {
        id: 6,
        label: '流程',
        url: "/callcenter/vdn/flow/flow.html"
      }, {
        id: 7,
        label: '客户级别',
        url: "/callcenter/vdn/customerGrade/customerGrade.html"
      }, {
        id: 8,
        label: '被叫配置',
        url: "/callcenter/vdn/calledConfig/calledConfig.html"
      }, {
        id: 9,
        label: '外呼配置',
        url: "/callcenter/vdn/calloutConfig/calloutConfig.html"
      }, {
        id: 10,
        label: '时间段配置',
        url: "/callcenter/vdn/calloutConfig/item.html"
      }, {
        id: 11,
        label: '数据源配置',
        url: "/callcenter/ivr/dataSource/dataSource.html"
      }, {
        id: 12,
        label: '服务配置',
        url: "/callcenter/ivr/interfaceConfig/interfaceConfig.html"
      }],
      defaultProps: {
        children: 'children',
        label: 'label'
      }
    };
  },
  watch: {
    filterText: function filterText(val) {
      this.$refs.tree2.filter(val);
    }
  },
  methods: {
    filterNode: function filterNode(value, data) {
      console.log(data + "-" + value);
      if (!value) return true;
      return data.label.indexOf(value) !== -1;
    },
    nodeClick: function nodeClick(data, value, elem) {
      if (data.url) {
        this.iframeUrl = data.url;
      }
    },

    /**
     * 界面适配
     */
    setWH: function setWH() {
      this.iframeWidth = document.body.clientWidth - document.getElementsByClassName('left')[0].clientWidth;
      this.iframeHeight = document.body.clientHeight;
    }
  },
  mounted: function mounted() {
    this.setWH();
  }
});