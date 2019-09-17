var vm = new Vue({
    el:'#rrapp',
    data:{
        username: '',
        password: '',
        captcha: '',
        error: false,
        errorMsg: '',
        user:{},
        src: 'captcha.jpg',
        loginBoxShow:true,
    },
    beforeCreate: function(){
        if(self != top){
            top.location.href = self.location.href;
        }
    },
    methods: {
        refreshCode: function(){
            this.src = "captcha.jpg?t=" + $.now();
        },
        login: function () {

            //var data = "username="+vm.username+"&password="+vm.password;
            $.ajax({
                type: "POST",
                url: "sys/login",
                contentType: "application/json",
                data: JSON.stringify({"type":1,username:vm.username,"password":vm.password}),
                dataType: "json",
                success: function(result){
                    if(result.code == 0){//登录成功
                        parent.location.href ='index.html';
                    }else{
                        vm.error = true;
                        vm.errorMsg = result.msg;
                        layer.msg(result.msg, {icon: 2});
                        vm.refreshCode();
                    }
                }
            });
        },
        register: function () {
            console.log(vm.user);
            if(vm.user.username == null || vm.user.username.toString().trim() == '' ){
                layer.msg("请输入用户名", {icon: 2});
                return;
            }
            if( vm.user.password == null || vm.user.password.toString().trim() == '' ){
                layer.msg("请输入密码", {icon: 2});
                return;
            }
            if(vm.user.companyName == null || vm.user.companyName.toString().trim() == ''   ){
                layer.msg("请输入企业名称", {icon: 2});
                return;
            }
            if(vm.user.email == '' ){
                layer.msg("请输入电子邮箱", {icon: 2});
                return;
            }
            if(vm.user.mobile == '' ){
                layer.msg("请输入联系方式", {icon: 2});
                return;
            }
            vm.user.type=2
            $.ajax({
                type: "POST",
                url:  "sys/login",
                contentType: "application/json",
                data: JSON.stringify(vm.user),
                success: function(r){
                    console.log(r)
                    if(r.code === 0){
                        layer.msg("注册成功，请登录", {icon: 1});
                        vm.loginBoxShow = true;
                    }else{
                       // console.log(r.msg)
                        //alert(r.msg);
                        if(r.msg=='数据库中已存在该记录'){
                            layer.msg("已经存在此用户", {icon: 2});
                        }else {
                            layer.msg(r.msg, {icon: 2});
                        }


                    }
                }
            });
        }
    }
});