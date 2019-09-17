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

  },
  callback: {
    onDblClick: questionzTreeOnDblClick
  }
};
var selectIds = new Array();
var questionByGrade_ztree;
var questionByGrade_setting = {
  data: {
    simpleData: {
      enable: true,
      idKey: "questionsId",
    },
    key: {
      url: "nourl",
      name: "grade"
    }
  }
};
var user_ztree;
var user_setting = {
  data: {
    simpleData: {
      enable: true,
      idKey: "userId",
    },
    key: {
      url: "nourl",
      name: "username"
    }
  },
  callback: {
    onDblClick: userzTreeOnDblClick
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


$(function() {
  $("#jqGrid").jqGrid({
    url: baseURL + 'sys/userquestion/list',
    datatype: "json",
    colModel: [{
        label: '题目名称',
        name: 'question',
        index: 'question',
        width: 160
      },
      {
        label: '用户名',
        name: 'username',
        index: 'username',
        width: 30
      },
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
});


var vm = new Vue({
  el: '#rrapp',
  data: {
    q: {
      username: null
    },
    showList: true,
    title: null,
    userquestion: {
      questionsId: 0,
      question: null,
      userId: 0,
      username: null,
      testsId: 0,
      testsName: null,
      grade: null
    }

  },
  methods: {
    getQuestion: function() {
      $.get(baseURL + "sys/questions/select", function(r) {
        question_ztree = $.fn.zTree.init($("#questionTree"), question_setting, r.questionList);
        var node = question_ztree.getNodeByParam("questionsId", vm.userquestion.questionsId);
        question_ztree.expandAll(true);
        question_ztree.selectNode(node);

      });
    },
    getQuestionByGrade: function() {
      $.get(baseURL + "sys/questions/selectByGrade", function(r) {
        questionByGrade_ztree = $.fn.zTree.init($("#questionByGradeTree"), questionByGrade_setting, r.questionsListByGrade);
        var node = questionByGrade_ztree.getNodeByParam("questionsId", vm.userquestion.questionsId);
        questionByGrade_ztree.expandAll(true);
        questionByGrade_ztree.selectNode(node);

      });
    },
    getUser: function() {
      $.get(baseURL + "sys/user/select", function(r) {
        user_ztree = $.fn.zTree.init($("#userTree"), user_setting, r.userList);
        var node = user_ztree.getNodeByParam("userId", vm.userquestion.userId);
        user_ztree.expandAll(true);
        user_ztree.selectNode(node);

      });
    },
    getTests: function() {
      $.get(baseURL + "sys/testsname/select", function(r) {
        tests_ztree = $.fn.zTree.init($("#testsTree"), tests_setting, r.testsList);
        var node = tests_ztree.getNodeByParam("id", vm.userquestion.testsId);
        tests_ztree.expandAll(true);
        tests_ztree.selectNode(node);

      });
    },
    userTree: function() {
      layer.open({
        type: 1,
        offset: '50px',
        skin: 'layui-layer-molv',
        title: "选择用户",
        area: ['300px', '450px'],
        shade: 0,
        shadeClose: false,
        content: jQuery("#userLayer"),
        btn: ['确定', '取消'],
        btn1: function(index) {
          var node = user_ztree.getSelectedNodes();
          vm.userquestion.username = node[0].username;
          layer.close(index);
        }
      });
    },

    query: function() {
      vm.reload();
    },
    add: function() {
      vm.showList = false;
      vm.title = "新增";
      vm.userquestion = {
        questionsId: 0,
        question: null,
        userId: 0,
        username: null,
      };
      vm.getQuestion();
      vm.getUser();

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
      vm.getUser();

    },
    saveOrUpdate: function(event) {
      $('#btnSaveOrUpdate').button('loading').delay(1000).queue(function() {
        var url = vm.userquestion.id == null ? "sys/userquestion/save" : "sys/userquestion/update";
        $.ajax({
          type: "POST",
          url: baseURL + url,
          contentType: "application/json",
          data: JSON.stringify(vm.userquestion),
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
            url: baseURL + "sys/userquestion/delete",
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
    addBatchByUserId: function(event) {
      vm.userquestion = {
        userId: 0,
        username: null,
      };
      var formData = new FormData();
      formData.append("questionsIds", selectIds);
      if (selectIds == null) {
        return;
      }
      vm.getUser();
      var index = layer.open({
        type: 1,
        title: '输入批量添加的用户名',
        skin: 'layui-layer-rim',
        area: ['450px', 'auto'],
        content: ' <div class="form-group"><input type="text" class="form-control" style="cursor:pointer;" id="choose" readonly="readonly" placeholder="用户名" /></div>  <div id="userLayer" style="display: none;padding:10px;"><ul id="userTree" class="ztree"></ul></div>',
        btn: ['确定', '取消'],
        btn1: function(index, layero) {
          var username = $('#choose').val();
          formData.append("username", username);
          $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: baseURL + "sys/userquestion/addBatchByUserId",
            data: formData,
            success: function(r) {
              if (r.code == 0) {
                layer.msg("操作成功", {
                  icon: 1
                });
                layer.close(index);
                $("#jqGrid").trigger("reloadGrid");
              } else {
                layer.alert(r.msg);
              }
            }
          });
        },
        btn2: function(index, layero) {
          layer.close(index);
        }
      });
      $('#choose').click(function() {
        layer.open({
          type: 1,
          offset: '50px',
          skin: 'layui-layer-molv',
          title: "选择用户",
          area: ['300px', '450px'],
          shade: 0,
          shadeClose: false,
          content: jQuery("#userLayer"),
          btn: ['确定', '取消'],
          btn1: function(index) {
            var node = user_ztree.getSelectedNodes();
            vm.userquestion.username = node[0].username;
            document.getElementById("choose").value = vm.userquestion.username;
            layer.close(index);
          }
        });
      });

    },
    addBatchByRandom: function(event) {
      vm.userquestion = {};
      var formData = new FormData();
      var index = layer.open({
        type: 1,
        title: '输入随机添加的题目数',
        skin: 'layui-layer-rim',
        area: ['450px', 'auto'],
        content: ' <div class="form-group"><input type="text" class="form-control" id="choose" placeholder="题目数"/></div> ',
        btn: ['确定', '取消'],
        btn1: function(index, layero) {
          var questionsNum = $('#choose').val();
          formData.append("questionsNum", questionsNum);
          $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: baseURL + "sys/userquestion/addBatchByRandom",
            data: formData,
            success: function(r) {
              if (r.code == 0) {
                layer.msg("操作成功", {
                  icon: 1
                });
                layer.close(index);
                $("#jqGrid").trigger("reloadGrid");
              } else {
                layer.alert(r.msg);
              }
            }
          });
        },
        btn2: function(index, layero) {
          layer.close(index);
        }
      });
    },
    addBatchByTestsId: function(event) {
      vm.userquestion = {
        testsId: 0,
        testsName: null,
      };
      questionsIds = selectIds;
      var formData = new FormData();
      formData.append("questionsIds", questionsIds);
      if (questionsIds == null) {
        return;
      }
      vm.getTests();
      var index = layer.open({
        type: 1,
        title: '输入批量添加的测试名',
        skin: 'layui-layer-rim',
        area: ['450px', 'auto'],
        content: ' <div class="form-group"><input type="text" class="form-control" style="cursor:pointer;" id="choose" readonly="readonly" placeholder="测试名" /></div>  <div id="testsLayer" style="display: none;padding:10px;"><ul id="testsTree" class="ztree"></ul></div>',
        btn: ['确定', '取消'],
        btn1: function(index, layero) {
          var testsName = $('#choose').val();
          formData.append("testsName", testsName);
          $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: baseURL + "sys/userquestion/addBatchByTestsId",
            data: formData,
            success: function(r) {
              if (r.code == 0) {
                layer.msg("操作成功", {
                  icon: 1
                });
                layer.close(index);
                $("#jqGrid").trigger("reloadGrid");
              } else {
                layer.alert(r.msg);
              }
            }
          });
        },
        btn2: function(index, layero) {
          layer.close(index);
        }
      });
      $('#choose').click(function() {
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
            vm.userquestion.testsName = node[0].testsName;
            document.getElementById("choose").value = vm.userquestion.testsName;
            layer.close(index);
          }
        });
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
          vm.userquestion.testsName = node[0].testsName;
          layer.close(index);
        }
      });

    },
    addBatchByGrade: function(event) {
      vm.userquestion = {
        questionsId: 0,
        grade: null,
        testsId: 0,
        testsName: null
      };
      var formData = new FormData();
      vm.getQuestionByGrade();
      vm.getTests();
      var index = layer.open({
        type: 1,
        title: '输入批量添加的类别及试卷名',
        skin: 'layui-layer-rim',
        area: ['450px', 'auto'],
        content: ' <div class="form-group"><input type="text" class="form-control" style="cursor:pointer;" id="choose" readonly="readonly" placeholder="级别" /></div> <div id="questionsByGradeLayer" style="display: none;padding:10px;"><ul id="questionByGradeTree" class="ztree"></ul></div> <div class="form-group"><input type="text" class="form-control" style="cursor:pointer;" id="choose2" readonly="readonly" placeholder="测试名" /></div> <div id="testsLayer" style="display: none;padding:10px;"><ul id="testsTree" class="ztree"></ul></div>',
        btn: ['确定', '取消'],
        btn1: function(index, layero) {
          var grade = $('#choose').val();
          var testsName = $('#choose2').val();
          formData.append("grade", grade);
          formData.append("testsName", testsName);
          $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: baseURL + "sys/userquestion/addBatchByGrade",
            data: formData,
            success: function(r) {
              if (r.code == 0) {
                layer.msg("操作成功", {
                  icon: 1
                });
                layer.close(index);
                $("#jqGrid").trigger("reloadGrid");
              } else {
                layer.alert(r.msg);
              }
            }
          });
        },
        btn2: function(index, layero) {
          layer.close(index);
        }
      });
      $('#choose').click(function() {
        layer.open({
          type: 1,
          offset: '50px',
          skin: 'layui-layer-molv',
          title: "选择级别",
          area: ['300px', '450px'],
          shade: 0,
          shadeClose: false,
          content: jQuery("#questionsByGradeLayer"),
          btn: ['确定', '取消'],
          btn1: function(index) {
            var node = questionByGrade_ztree.getSelectedNodes();
            vm.userquestion.grade = node[0].grade;
            document.getElementById("choose").value = vm.userquestion.grade;
            layer.close(index);
          }
        });
      });
      $('#choose2').click(function() {
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
            vm.userquestion.testsName = node[0].testsName;
            document.getElementById("choose2").value = vm.userquestion.testsName;
            layer.close(index);
          }
        });
      });

    },
    getInfo: function(id) {
      $.get(baseURL + "sys/userquestion/info/" + id, function(r) {
        vm.userquestion = r.userquestion;
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
          vm.userquestion.question = node[0].question;
          layer.close(index);
        }
      });
    },
    reload: function(event) {
      vm.showList = true;
      var page = $("#jqGrid").jqGrid('getGridParam', 'page');
      $("#jqGrid").jqGrid('setGridParam', {
        postData: {
          'username': vm.q.username
        },
        page: page
      }).trigger("reloadGrid");
    },
    jumpToSelect: function(event) {
      var url = baseURL + "sys/questions/selectAll";
      $("#usernameInput").remove();
      $("#query").remove();
      $("#add").remove();
      $("#update").remove();
      $("#del").remove();
      $("#gbox_jqGrid").remove();
      if (!document.getElementById("addBatchByUserId")) {
        $('.grid-btn').append('<a class="btn btn-primary" id="addBatchByUserId" @click="addBatchByUserId">&nbsp;按用户添加</a>');
      }
      if (!document.getElementById("addBatchByTestsId")) {
        $('.grid-btn').append('<a class="btn btn-primary" id="addBatchByTestsId" @click="addBatchByTestsId">&nbsp;按测试添加</a>');
      }
      if (!document.getElementById("addBatchByGrade")) {
        $('.grid-btn').append('<a class="btn btn-primary" id="addBatchByGrade" @click="addBatchByGrade">&nbsp;按级别添加</a>');
      }
      if (!document.getElementById("addBatchByRandom")) {
        $('.grid-btn').append('<a class="btn btn-primary" id="addBatchByRandom" @click="addBatchByRandom">&nbsp;随机添加</a>');
      }
      if (!document.getElementById("refresh")) {
        $('.grid-btn').append('<a class="btn btn-primary" id="refresh" @click="refresh">&nbsp;返回</a>');
      }
      //强制清除grid容器的html,这个标签在渲染表格后由jqgrid创建的表格最外层标签
      $("body").append('<table id="jqGrid"></table><div id="jqGridPager"></div>');
      $('#addBatchByUserId').click(function() {
        vm.addBatchByUserId();
      });
      $('#addBatchByGrade').click(function() {
        vm.addBatchByGrade();
      });
      $('#addBatchByTestsId').click(function() {
        vm.addBatchByTestsId();
      });
      $('#addBatchByRandom').click(function() {
        vm.addBatchByRandom();
      });
      $('#refresh').click(function() {
        location.reload(true);
      });
      $("body").find("#jqGrid").jqGrid({
        url: baseURL + 'sys/questions/selectAll',
        datatype: "json",
        colModel: [{
            label: '问题编号',
            name: 'questionsId',
            index: 'questions_id',
            width: 30,
            key: true
          },

          {
            label: '题目名称',
            name: 'question',
            index: 'question',
            width: 160
          },
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
        onSelectAll: function(aRowids, status) {
          if (status == true) {
            $.each(aRowids, function(i, item) {
              saveIdToArray(item);
            });
          } else {
            $.each(aRowids, function(i, item) {
              deleteIdFromArray(item);
            });
          }
        },
        onSelectRow: function(aRowids, status) {
          if (status == true) { //选择
            saveIdToArray(aRowids);
          } else { //取消选择
            deleteIdFromArray(aRowids);

          }
        },
        gridComplete: function() {
          //隐藏grid底部滚动条
          var _this = this;
          if(selectIds.length > 0){
            for (var i=0; i < selectIds.length; i++){

              $(_this).jqGrid('setSelection',selectIds[i],false);
            }
          }
          $("#jqGrid").closest(".ui-jqgrid-bdiv").css({
            "overflow-x": "hidden"
          });


        }
      }).trigger("reloadGrid");
    }
  }
});

function saveIdToArray(item){

   var exit = false;
   for(var i = 0;i < selectIds.length;i++){
    if(item == selectIds[i]){
     exit = true;
     break;
    }
 }
  selectIds.push(item);
 }
//从数组中删除
function deleteIdFromArray(item){
 if(selectIds.length > 0){
  for(var i = 0;i < selectIds.length;i++){
   if(item == selectIds[i]){
    selectIds.splice(i,1);
    break;
   }
  }
 }
}
function questionzTreeOnDblClick(event, treeId, treeNode) {

  var node = question_ztree.getSelectedNodes();
  vm.userquestion.question = node[0].question;
}

function userzTreeOnDblClick (event, treeId, treeNode) {
  console.log(treeId,treeNode);
  vm.userquestion.username = treeNode.username;
  document.getElementById("choose").value = vm.userquestion.username;
  layer.close(layer.index);
}
