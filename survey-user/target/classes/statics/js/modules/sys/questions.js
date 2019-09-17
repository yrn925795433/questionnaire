$(function () {
    $("#jqGrid").jqGrid({
        url: baseURL + 'sys/questions/list',
        datatype: "json",
        colModel: [			
			{ label: 'questionsId', name: 'questionsId', index: 'questions_id', width: 50, key: true },
			{ label: '等级', name: 'grade', index: 'grade', width: 80 }, 			
			{ label: '分类', name: 'mainclass', index: 'mainclass', width: 80 }, 			
			{ label: '子域名称', name: 'subclass', index: 'subclass', width: 80 }, 			
			{ label: '子域权重', name: 'subweight', index: 'subweight', width: 80 }, 			
			{ label: '题目名称', name: 'question', index: 'question', width: 80 }, 			
			{ label: '题目权重', name: 'quweight', index: 'quweight', width: 80 }, 			
			{ label: '答案1', name: 'answer1', index: 'answer1', width: 80 }, 			
			{ label: '答案2', name: 'answer2', index: 'answer2', width: 80 }, 			
			{ label: '答案3', name: 'answer3', index: 'answer3', width: 80 }, 			
			{ label: '答案4', name: 'answer4', index: 'answer4', width: 80 }			
        ],
		viewrecords: true,
        height: 385,
        rowNum: 10,
		rowList : [10,30,50],
        rownumbers: true, 
        rownumWidth: 25, 
        autowidth:true,
        multiselect: true,
        pager: "#jqGridPager",
        jsonReader : {
            root: "page.list",
            page: "page.currPage",
            total: "page.totalPage",
            records: "page.totalCount"
        },
        prmNames : {
            page:"page", 
            rows:"limit", 
            order: "order"
        },
        gridComplete:function(){
        	//隐藏grid底部滚动条
        	$("#jqGrid").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" }); 
        }
    });
});

var vm = new Vue({
	el:'#rrapp',
	data:{
		showList: true,
		title: null,
		questions: {}
	},
	methods: {
		query: function () {
			vm.reload();
		},
		add: function(){
			vm.showList = false;
			vm.title = "新增";
			vm.questions = {};
		},
		update: function (event) {
			var questionsId = getSelectedRow();
			if(questionsId == null){
				return ;
			}
			vm.showList = false;
            vm.title = "修改";
            
            vm.getInfo(questionsId)
		},
		saveOrUpdate: function (event) {
		    $('#btnSaveOrUpdate').button('loading').delay(1000).queue(function() {
                var url = vm.questions.questionsId == null ? "sys/questions/save" : "sys/questions/update";
                $.ajax({
                    type: "POST",
                    url: baseURL + url,
                    contentType: "application/json",
                    data: JSON.stringify(vm.questions),
                    success: function(r){
                        if(r.code === 0){
                             layer.msg("操作成功", {icon: 1});
                             vm.reload();
                             $('#btnSaveOrUpdate').button('reset');
                             $('#btnSaveOrUpdate').dequeue();
                        }else{
                            layer.alert(r.msg);
                            $('#btnSaveOrUpdate').button('reset');
                            $('#btnSaveOrUpdate').dequeue();
                        }
                    }
                });
			});
		},
		del: function (event) {
			var questionsIds = getSelectedRows();
			if(questionsIds == null){
				return ;
			}
			var lock = false;
            layer.confirm('确定要删除选中的记录？', {
                btn: ['确定','取消'] //按钮
            }, function(){
               if(!lock) {
                    lock = true;
		            $.ajax({
                        type: "POST",
                        url: baseURL + "sys/questions/delete",
                        contentType: "application/json",
                        data: JSON.stringify(questionsIds),
                        success: function(r){
                            if(r.code == 0){
                                layer.msg("操作成功", {icon: 1});
                                $("#jqGrid").trigger("reloadGrid");
                            }else{
                                layer.alert(r.msg);
                            }
                        }
				    });
			    }
             }, function(){
             });
		},
		getInfo: function(questionsId){
			$.get(baseURL + "sys/questions/info/"+questionsId, function(r){
                vm.questions = r.questions;
            });
		},
		reload: function (event) {
			vm.showList = true;
			var page = $("#jqGrid").jqGrid('getGridParam','page');
			$("#jqGrid").jqGrid('setGridParam',{ 
                page:page
            }).trigger("reloadGrid");
		}
	}
});