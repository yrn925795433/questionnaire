var user_ztree;
var user_setting = {
  data: {
    simpleData: {
      enable: true,
      idKey: "userId",
      pIdKey: "parentId",
      rootPId: -1
    },
    key: {
      url: "nourl",
      name: "username"
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

$(function() {
  $("#jqGrid").jqGrid({
    url: baseURL + 'sys/tests/list',
    datatype: "json",
    colModel: [
      {
          label: '测试名',
          name: 'testsName',
          index: 'tests_name',
          width: 50,
        },
      {
        label: '用户名',
        name: 'username',
        index: 'username',
        width: 80
      },
      {
        label: '测试状态',
        name: 'testStatus',
        index: 'test_status',
        width: 80
      },
      {
        label: '测试时间',
        name: 'testTime',
        index: 'test_time',
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
});

var vm = new Vue({
      el: '#rrapp',
      data: {
        showList: true,
        title: null,
        tests: {
          userId: 0,
          username: null,
          testsId:0,
          testsName:null
        },
        q: {
          testsName: null
        },
        rowCount: 1
      },
      methods: {
        query: function() {
          vm.reload();
        },
        getUser: function() {

          $.get(baseURL + "sys/user/select", function(r) {
            user_ztree = $.fn.zTree.init($("#userTree"), user_setting, r.userList);
            var node = user_ztree.getNodeByParam("userId", vm.tests.parentId);
            user_ztree.expandAll(true);
            user_ztree.selectNode(node);

          });
        },
        getTests: function() {
          $.get(baseURL + "sys/testsname/select", function(r) {
            tests_ztree = $.fn.zTree.init($("#testsTree"), tests_setting, r.testsList);
            var node = tests_ztree.getNodeByParam("id",vm.tests.id);
            tests_ztree.expandAll(true);
            tests_ztree.selectNode(node);

          });
        },

        add: function() {
          vm.showList = false;
          vm.title = "新增";
          vm.tests = {
            userId: 0,
            username: null,
            testsId:0,
            testsName:null
          };
          vm.getUser();
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
          vm.getUser();
          vm.getTests();
        },
        saveOrUpdate: function(event) {
          $('#btnSaveOrUpdate').button('loading').delay(1000).queue(function() {
            var url = vm.tests.id == null ? "sys/tests/save" : "sys/tests/update";
            $.ajax({
              type: "POST",
              url: baseURL + url,
              contentType: "application/json",
              data: JSON.stringify(vm.tests),
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
                url: baseURL + "sys/tests/delete",
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
          $.get(baseURL + "sys/tests/info/" + id, function(r) {
            vm.tests = r.tests;
          });
        },
        addBatch: function(event) {
          vm.tests = {
            userId: 0,
            username: null,
          };
          var testsId = getSelectedRow();
          var formData = new FormData();
          formData.append("testsId", testsId);
          if (testsId == null) {
            return;
          }
          vm.getUser();
          var index = layer.open({
            type: 1,
            title: '输入批量添加的用户名',
            skin: 'layui-layer-rim',
            area: ['450px', 'auto'],
            content: ' <div class="form-group"><input type="text" class="form-control" style="cursor:pointer;" id="choose1" readonly="readonly" placeholder="用户名"  /> <button class="btn btn-info" type="button" data-toggle="tooltip" title="新增" id="addCenterIpGrpBtn" ><span class="glyphicon glyphicon-plus"></span></button> </div> <div id="userLayer" style="display: none;padding:10px;"><ul id="userTree" class="ztree"></ul></div>',
            btn: ['确定', '取消'],
            btn1: function(index, layero) {
              var usernameArray = new Array();
              for (var i = 1; i <= vm.rowCount; i++) {
                var username = $(".form-group").find("#choose"+i).val();
                usernameArray.push(username);
              }
              formData.append("username", usernameArray);
              $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: baseURL + "sys/tests/addBatch",
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
          vm.getUser();
          $('#choose1').click(function() {
            var index = layer.open({
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
                vm.tests.username = node[0].username;
                document.getElementById("choose1").value = vm.tests.username;
                layer.close(index);
              }
            });
          });
          $('#addCenterIpGrpBtn').click(function() {
              vm.rowCount++;
              var columnAppend = '<input type="text" class="form-control" style="cursor:pointer;" id="choose' + vm.rowCount + '" readonly="readonly" placeholder="用户名" />';
              $('.form-group').append(columnAppend);
            });
            $(".form-group").on('click', ".form-control",function(){
                  var i = vm.rowCount;
                  console.log(i);
                  var index = layer.open({
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
                      vm.tests.username = node[0].username;
                      // document.getElementById("choose"+i).value = vm.tests.username;
                      $(".form-group").find("#choose"+i).val(vm.tests.username);


                      layer.close(index);
                    }
                  });
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
                      vm.tests.username = node[0].username;
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
                      vm.tests.testsName = node[0].testsName;
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
                },
                addTests:function(){
                  var formData = new FormData();
                  var index = layer.open({
                    type: 1,
                    title: '输入测试名',
                    skin: 'layui-layer-rim',
                    area: ['450px', '450px'],
                    content: ' <div class="form-group"><input type="text" class="form-control"  id="choose"  placeholder="测试名" />',
                    btn: ['确定', '取消'],
                    btn1: function(index, layero) {
                      var testsName = $('#choose').val();
                      formData.append("testsName",testsName);
                      $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,
                        url: baseURL + "sys/answers/addTests",
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
                jumpToSelect: function(event) {
                  //     $("#jqGrid").jqGrid("clearGridData");
                  // var url = baseURL + "sys/answers/list";
                  $("#testsNameInput").remove();
                  $("#add").remove();
                  $("#update").remove();
                  $("#del").remove();
                  $("#gbox_jqGrid").remove();
                  $("#query").remove();
                  if(! document.getElementById("addTests")){
                  $('.grid-btn').append('<a class="btn btn-primary"  id="addTests" @click="addTests"><i class="fa fa-plus"></i>&nbsp;添加测试</a>');}
                  if(! document.getElementById("addBatchByUserId")){
                  $('.grid-btn').append('<a class="btn btn-primary"  id="addBatch" @click="addBatch"><i class="fa fa-plus"></i>&nbsp;批量添加</a>');}
                  if(! document.getElementById("refresh")){
                  $('.grid-btn').append('<a class="btn btn-primary" id="refresh" @click="refresh">&nbsp;返回</a>');}
                  //强制清除grid容器的html,这个标签在渲染表格后由jqgrid创建的表格最外层标签
                  $("body").append('<table id="jqGrid"></table><div id="jqGridPager"></div>');
                  $('#addTests').click(function() {
                    vm.addTests();
                    });
                  $('#addBatch').click(function() {
                    vm.addBatch();
                    });
                  $('#refresh').click(function() {
                    location.reload(true);
                  });
                  $("#jqGrid").jqGrid({
                    url: baseURL + 'sys/testsname/list',
                    datatype: "json",
                    colModel: [{
                        label: '测试名',
                        name: 'testsName',
                        index: 'tests_name',
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
                  }).trigger("reloadGrid");
                }
            }
          });
