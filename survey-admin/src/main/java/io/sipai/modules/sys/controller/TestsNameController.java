package io.sipai.modules.sys.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;

import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;
import io.sipai.common.utils.R;
import io.sipai.modules.sys.entity.AnswersEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.TestsNameEntity;
import io.sipai.modules.sys.service.TestsNameService;

@RestController
@RequestMapping("sys/testsname")
public class TestsNameController {

	@Autowired
	private TestsNameService testsNameService;

	@RequestMapping("/select")
	public R select() {

		List<TestsNameEntity> testsNameList = testsNameService.list();
		return R.ok().put("testsList", testsNameList);

	}
	
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
    	
        PageUtils page = testsNameService.queryPage(params);

        return R.ok().put("page", page);
    }

}
