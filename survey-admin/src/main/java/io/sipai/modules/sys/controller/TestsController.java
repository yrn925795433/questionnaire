package io.sipai.modules.sys.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.sipai.common.validator.ValidatorUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysUserEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.TestsNameEntity;
import io.sipai.modules.sys.entity.UserquestionEntity;
import io.sipai.modules.sys.service.SysUserService;
import io.sipai.modules.sys.service.TestsNameService;
import io.sipai.modules.sys.service.TestsService;
import lombok.experimental.var;
import io.sipai.common.annotation.SysLog;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.R;

/**
 * 测试管理
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@RestController
@RequestMapping("sys/tests")
public class TestsController {
	@Autowired
	private TestsService testsService;

	@Autowired
	private SysUserService sysUserService;
	
	@Autowired 
	private TestsNameService testsNameService;

	/**
	 * 列表
	 */
	@RequestMapping("/list")
	@RequiresPermissions("sys:tests:list")
	public R list(@RequestParam Map<String, Object> params) {
		PageUtils page = testsService.queryPage(params);

		return R.ok().put("page", page);
	}

	/**
	 * 信息
	 */
	@RequestMapping("/info/{id}")
	@RequiresPermissions("sys:tests:info")
	public R info(@PathVariable("id") Long id) {
		TestsEntity tests = testsService.getById(id);
		
		QueryWrapper<TestsNameEntity> firstQueryWrapper = new QueryWrapper<>();
		firstQueryWrapper.eq("tests_id", tests.getTestsId());
		TestsNameEntity testsNameEntity = testsNameService.getOne(firstQueryWrapper);
		if (testsNameEntity != null) {
			tests.setTestsName(testsNameEntity.getTestsName());
		}
		
		QueryWrapper<SysUserEntity> secondQueryWrapper = new QueryWrapper<>();
		secondQueryWrapper.eq("user_id", tests.getUserId());
		SysUserEntity sysUserEntity = sysUserService.getOne(secondQueryWrapper);
		if (sysUserEntity != null) {
			tests.setUsername(sysUserEntity.getUsername());
		}
		
		return R.ok().put("tests", tests);
	}

	/**
	 * 保存
	 */
	@SysLog("保存测试与用户名对应关系")
	@RequestMapping("/save")
	@RequiresPermissions("sys:tests:save")
	public R save(@RequestBody TestsEntity tests) {
		
		QueryWrapper<TestsNameEntity> firstQueryWrapper = new QueryWrapper<>();
		firstQueryWrapper.eq("tests_name", tests.getTestsName());
		TestsNameEntity testsNameEntity = testsNameService.getOne(firstQueryWrapper);
		if (testsNameEntity != null) {
			tests.setTestsId(testsNameEntity.getTestsId());
		}
		
		QueryWrapper<SysUserEntity> secondQueryWrapper = new QueryWrapper<>();
		secondQueryWrapper.eq("username", tests.getUsername());
		SysUserEntity sysUserEntity = sysUserService.getOne(secondQueryWrapper);
		if (sysUserEntity != null) {
			tests.setUserId(sysUserEntity.getUserId());
		}
		
		testsService.save(tests);

		return R.ok();
	}

	/**
	 * 修改
	 */
	@SysLog("修改测试与用户名对应关系")
	@RequestMapping("/update")
	@RequiresPermissions("sys:tests:update")
	public R update(@RequestBody TestsEntity tests) {
		
		QueryWrapper<TestsNameEntity> firstQueryWrapper = new QueryWrapper<>();
		firstQueryWrapper.eq("tests_name", tests.getTestsName());
		TestsNameEntity testsNameEntity = testsNameService.getOne(firstQueryWrapper);
		if (testsNameEntity != null) {
			tests.setTestsId(testsNameEntity.getTestsId());
		}
		
		
		QueryWrapper<SysUserEntity> secondQueryWrapper = new QueryWrapper<>();
		secondQueryWrapper.eq("username", tests.getUsername());
		SysUserEntity sysUserEntity = sysUserService.getOne(secondQueryWrapper);
		if (sysUserEntity != null) {
			tests.setUserId(sysUserEntity.getUserId());
		}
		
		ValidatorUtils.validateEntity(tests);
		testsService.updateById(tests);

		return R.ok();
	}

	/**
	 * 删除
	 */
	@SysLog("删除测试与用户名对应关系")
	@RequestMapping("/delete")
	@RequiresPermissions("sys:tests:delete")
	public R delete(@RequestBody Long[] testsIds) {
		testsService.removeByIds(Arrays.asList(testsIds));

		return R.ok();
	}
	
	@SysLog("批量添加测试与用户名对应关系")
	@RequestMapping("/addBatch")
	@RequiresPermissions("sys:tests:addBatch")
	public R addBatch(@RequestParam Map<String, Object> params) {
		String testsId = (String) params.get("testsId");
		Long testsIdLong = Long.parseLong(testsId);
		String usernames = (String) params.get("username");
		String[] usernameList = usernames.split(",");

		TestsNameEntity testsNameEntity = testsNameService.getById(testsIdLong);

		for (String username : usernameList) {

			QueryWrapper<SysUserEntity> queryWrapper = new QueryWrapper<>();
			queryWrapper.eq("username", username);
			SysUserEntity sysUserEntity = sysUserService.getOne(queryWrapper);
			
			TestsEntity testsEntity = new TestsEntity();
			
			if (testsNameEntity != null) {
				testsEntity.setTestsId(testsIdLong);

			}
			testsEntity.setUserId(sysUserEntity.getUserId());
			testsEntity.setTestStatus(0L);
			testsService.save(testsEntity);
		}

		return R.ok();
	}
}
