$(function () {
    $("#jqGrid").jqGrid({
        url: baseURL + 'sys/useranswer/list',
        datatype: "json",
        colModel: [			
			{ label: '编号', name: 'answersId', index: 'answers_id', width: 30, key: true },
            { label: '题目名称', name: 'question', index: 'question', width: 160 },
            { label: '选项1', name: 'option1', index: 'option1', width: 60 },
            { label: '选项2', name: 'option2', index: 'option2', width: 60 },
            { label: '选项3', name: 'option3', index: 'option3', width: 60 },
            { label: '选项4', name: 'option4', index: 'option4', width: 60 },
            { label: '所选答案', name: 'ansnumber', index: 'ansnumber', width: 40 },
			{ label: '答题时间', name: 'anstime', index: 'anstime', width: 50 }
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
		useranswer: {}
	},
	methods: {
		query: function () {
			vm.reload();
		},
		add: function(){
			vm.showList = false;
			vm.title = "新增";
			vm.useranswer = {};
		},
		update: function (event) {
			var answersId = getSelectedRow();
			if(answersId == null){
				return ;
			}
			vm.showList = false;
            vm.title = "修改";
            
            vm.getInfo(answersId)
		},
		saveOrUpdate: function (event) {
		    $('#btnSaveOrUpdate').button('loading').delay(1000).queue(function() {
                var url = vm.useranswer.answersId == null ? "sys/useranswer/save" : "sys/useranswer/update";
                $.ajax({
                    type: "POST",
                    url: baseURL + url,
                    contentType: "application/json",
                    data: JSON.stringify(vm.useranswer),
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
			var answersIds = getSelectedRows();
			if(answersIds == null){
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
                        url: baseURL + "sys/useranswer/delete",
                        contentType: "application/json",
                        data: JSON.stringify(answersIds),
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
		getInfo: function(answersId){
			$.get(baseURL + "sys/useranswer/info/"+answersId, function(r){
                vm.useranswer = r.useranswer;
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