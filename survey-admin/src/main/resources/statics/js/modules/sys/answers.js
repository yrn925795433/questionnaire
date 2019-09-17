var question_ztree;
var question_setting = {
  data: {
    simpleData: {
      enable: true,
      idKey: "questionsId",
    },
    key: {
      url: "nourl",
      name: "question"
    }
  }
};

var tests_ztree;
var tests_setting = {
  data: {
    simpleData: {
      enable: true,
      idKey: "userId",

    },
    key: {
      url: "nourl",
      name: "testsName"
    }
  }
};

var rowCount = 0;

$(function() {
  $("#jqGrid").jqGrid({
    url: baseURL + 'sys/answers/list',
    datatype: "json",
    colModel: [
      {
        label: '测试名',
        name: 'testsName',
        index: 'tests_name',
        width: 80
      },
      {
        label: '问题',
        name: 'question',
        index: 'question',
        width: 80
      }
    ],
    viewrecords: true,
    height: 385,
    rowNum: 10,
    rowList: [10, 30, 50],
    rownumbers: true,
    rownumWidth: 25,
    autowidth: true,
    multiselect: true,
    pager: "#jqGridPager",
    jsonReader: {
      root: "page.list",
      page: "page.currPage",
      total: "page.totalPage",
      records: "page.totalCount"
    },
    prmNames: {
      page: "page",
      rows: "limit",
      order: "order"
    },
    gridComplete: function() {
      //隐藏grid底部滚动条
      $("#jqGrid").closest(".ui-jqgrid-bdiv").css({
        "overflow-x": "hidden"
      });
    }
  });
  $("#jqGrid").on("click", ".mark_data", function(){
    testsId = $(this).attr("id");
    $.get(baseURL + "sys/answers/questionList/" + testsId, function(r) {
      vm.answers = r.answers;
      layer.open({
        type: 1,
        offset: '50px',
        skin: 'layui-layer-molv',
        title: "问题",
        area: ['300px', '450px'],
        shade: 0,
        shadeClose: false,
        content: jQuery("#questionLayer"),
        btn: ['确定', '取消'],
        btn1: function(index) {
          layer.close(index);
        }
      });
    });
  });
});


var vm = new Vue({
  el: '#rrapp',
  data: {
    showList: true,
    title: null,
    answers: {
      questionsId: 0,
      question: null,
      testsId: 0,
      testsName: null
    },
    q: {
      testsName: null
    },
  },
  methods: {
    query: function() {
      vm.reload();
    },

    getQuestion: function() {
      $.get(baseURL + "sys/questions/select", function(r) {
        question_ztree = $.fn.zTree.init($("#questionTree"), question_setting, r.questionList);
        var node = question_ztree.getNodeByParam("questionsId", vm.answers.questionsId);
        question_ztree.expandAll(true);
        question_ztree.selectNode(node);
      });
    },
    getTests: function() {
      $.get(baseURL + "sys/testsname/select", function(r) {
        tests_ztree = $.fn.zTree.init($("#testsTree"), tests_setting, r.testsList);
        var node = tests_ztree.getNodeByParam("testsId", vm.answers.testsId);
        tests_ztree.expandAll(true);
        tests_ztree.selectNode(node);

      });
    },
    addTests: function() {
      vm.showList = false;
      vm.title = "新增测试";
      vm.answers = {};
      $('#question').remove();
      $('.form-control').remove();
      $('#testsNameCol').append('<input type="text" class="form-control" id="choose" placeholder="测试名" />');
      console.log(vm.answers);
    },
    add: function() {
      vm.showList = false;
      vm.title = "新增";
      vm.answers = {};
      vm.getQuestion();
      vm.getTests();
    },
    update: function(event) {
      var id = getSelectedRow();
      if (id == null) {
        return;
      }
      vm.showList = false;
      vm.title = "修改";
      vm.getInfo(id);
      vm.getQuestion();
      vm.getTests();
    },
    saveOrUpdate: function(event) {
      $('#btnSaveOrUpdate').button('loading').delay(1000).queue(function() {
        var url = vm.answers.id == null ? "sys/answers/save" : "sys/answers/update";
        $.ajax({
          type: "POST",
          url: baseURL + url,
          contentType: "application/json",
          data: JSON.stringify(vm.answers),
          success: function(r) {
            if (r.code === 0) {
              layer.msg("操作成功", {
                icon: 1
              });
              vm.reload();
              $('#btnSaveOrUpdate').button('reset');
              $('#btnSaveOrUpdate').dequeue();
            } else {
              layer.alert(r.msg);
              $('#btnSaveOrUpdate').button('reset');
              $('#btnSaveOrUpdate').dequeue();
            }
          }
        });
      });
    },
    del: function(event) {
      var ids = getSelectedRows();
      if (ids == null) {
        return;
      }
      var lock = false;
      layer.confirm('确定要删除选中的记录？', {
        btn: ['确定', '取消'] //按钮
      }, function() {
        if (!lock) {
          lock = true;
          $.ajax({
            type: "POST",
            url: baseURL + "sys/answers/delete",
            contentType: "application/json",
            data: JSON.stringify(ids),
            success: function(r) {
              if (r.code == 0) {
                layer.msg("操作成功", {
                  icon: 1
                });
                $("#jqGrid").trigger("reloadGrid");
              } else {
                layer.alert(r.msg);
              }
            }
          });
        }
      }, function() {});
    },
    getInfo: function(id) {
      $.get(baseURL + "sys/answers/info/" + id, function(r) {
        vm.answers = r.answers;
      });
    },
    questionTree: function() {
      layer.open({
        type: 1,
        offset: '50px',
        skin: 'layui-layer-molv',
        title: "选择问题",
        area: ['300px', '450px'],
        shade: 0,
        shadeClose: false,
        content: jQuery("#questionLayer"),
        btn: ['确定', '取消'],
        btn1: function(index) {
          var node = question_ztree.getSelectedNodes();
          vm.answers.question = node[0].question;
          layer.close(index);
        }
      });
    },
    testsTree: function() {
      layer.open({
        type: 1,
        offset: '50px',
        skin: 'layui-layer-molv',
        title: "选择测试",
        area: ['300px', '450px'],
        shade: 0,
        shadeClose: false,
        content: jQuery("#testsLayer"),
        btn: ['确定', '取消'],
        btn1: function(index) {
          var node = tests_ztree.getSelectedNodes();
          vm.answers.testsName = node[0].testsName;
          layer.close(index);
        }
      });

    },
    reload: function(event) {
      vm.showList = true;
      var page = $("#jqGrid").jqGrid('getGridParam', 'page');
      $("#jqGrid").jqGrid('setGridParam', {
        postData: {
          'testsName': vm.q.testsName
        },
        page: page
      }).trigger("reloadGrid");
    }
  }
});
