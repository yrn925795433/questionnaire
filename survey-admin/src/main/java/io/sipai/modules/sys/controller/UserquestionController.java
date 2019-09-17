package io.sipai.modules.sys.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
import io.sipai.modules.sys.entity.SysRoleEntity;
import io.sipai.modules.sys.entity.SysUserEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.TestsNameEntity;
import io.sipai.modules.sys.entity.UseranswerEntity;
import io.sipai.modules.sys.entity.UserquestionEntity;
import io.sipai.modules.sys.service.QuestionsService;
import io.sipai.modules.sys.service.SysUserService;
import io.sipai.modules.sys.service.TestsNameService;
import io.sipai.modules.sys.service.TestsService;
import io.sipai.modules.sys.service.UserquestionService;
import lombok.experimental.var;
import oracle.net.aso.i;
import io.sipai.common.annotation.SysLog;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.R;

/**
 * 用户答题
 *
 * @author Leo
 * 
 */
@RestController
@RequestMapping("sys/userquestion")
public class UserquestionController {
	@Autowired
	private UserquestionService userquestionService;

	@Autowired
	private QuestionsService questionsService;

	@Autowired
	private SysUserService sysUserService;

	@Autowired
	private TestsService testsService;
	@Autowired
	private TestsNameService testsNameService;

	/**
	 * 列表
	 */
	@RequestMapping("/list")
	@RequiresPermissions("sys:userquestion:list")
	public R list(@RequestParam Map<String, Object> params) {
		PageUtils page = userquestionService.queryPage(params);
		return R.ok().put("page", page);
	}

//	@RequestMapping("/select")
//	public R select(){
//		
//		List<QuestionsEntity> questionList = userquestionService.queryList(new HashMap<String, Object>());
//		return R.ok().put("questionList", questionList);
//	}

	/**
	 * 信息
	 */
	@RequestMapping("/info/{id}")
	@RequiresPermissions("sys:userquestion:info")
	public R info(@PathVariable("id") Long id) {
		UserquestionEntity userquestion = userquestionService.getById(id);

		QuestionsEntity questionsEntity = questionsService.getById(userquestion.getQuestionsId());

		if (questionsEntity != null) {
			userquestion.setQuestion(questionsEntity.getQuestion());
		}

		TestsEntity testsEntity = testsService.getById(userquestion.getTestsId());
		if (testsEntity != null) {
			SysUserEntity sysUserEntity = sysUserService.getById(testsEntity.getUserId());
			if (sysUserEntity != null) {
				userquestion.setUsername(sysUserEntity.getUsername());
			}

		}
		return R.ok().put("userquestion", userquestion);

	}

	/**
	 * 保存
	 */
	@SysLog("保存用户选择")
	@RequestMapping("/save")
	@RequiresPermissions("sys:userquestion:save")
	public R save(@RequestBody UserquestionEntity userquestion) {


		return R.ok();
	}
	
	@SysLog("修改用户选择")
	@RequestMapping("/update")
	@RequiresPermissions("sys:userquestion:update")
	public R update(@RequestBody UserquestionEntity userquestion) {

		return R.ok();
	}
	
	@SysLog("删除用户选择")
	@RequestMapping("/delete")
	@RequiresPermissions("sys:userquestion:delete")
	public R delete(@RequestBody Long[] ids) {
		userquestionService.deleteBatch(ids);

		return R.ok();
	}
	
	@SysLog("根据用户名选题")
	@RequestMapping("/addBatchByUserId")
	@RequiresPermissions("sys:userquestion:addBatchByUserId")
	public R addBatchByUserId(@RequestParam Map<String, Object> params) {
		String username = (String) params.get("username");
		String questionsIds = (String) params.get("questionsIds");
		String[] questionsIdsLong = questionsIds.split(",");

		QueryWrapper<SysUserEntity> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("username", username);
		SysUserEntity sysUserEntity = sysUserService.getOne(queryWrapper);

		TestsNameEntity testsNameEntity = new TestsNameEntity();
		testsNameEntity.setTestsName("测试" + username);
		testsNameService.save(testsNameEntity);

		TestsEntity testsEntity = new TestsEntity();
		testsEntity.setTestsId(testsNameEntity.getTestsId());
		testsEntity.setUserId(sysUserEntity.getUserId());
		testsEntity.setTestStatus(0L);
		testsService.save(testsEntity);

		for (String questionsId : questionsIdsLong) {
			Long questionsIdLong = Long.parseLong(questionsId);

			UserquestionEntity userquestion = new UserquestionEntity();
			userquestion.setQuestionsId(questionsIdLong);
			userquestion.setTestsId(testsEntity.getTestsId());
			userquestionService.save(userquestion);
		}

		return R.ok();
	}
	@SysLog("根据测试名选题")
	@RequestMapping("/addBatchByTestsId")
	@RequiresPermissions("sys:userquestion:addBatchByTestsId")
	public R addBatchByTestsId(@RequestParam Map<String, Object> params) {
		String testsName = (String) params.get("testsName");
		String questionsIds = (String) params.get("questionsIds");
		String[] questionsIdsLong = questionsIds.split(",");

		QueryWrapper<TestsNameEntity> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("tests_name", testsName);
		TestsNameEntity testsNameEntity = testsNameService.getOne(queryWrapper);

		for (String questionsId : questionsIdsLong) {
			Long questionsIdLong = Long.parseLong(questionsId);

			UserquestionEntity userquestion = new UserquestionEntity();
			userquestion.setQuestionsId(questionsIdLong);
			userquestion.setTestsId(testsNameEntity.getTestsId());
			userquestionService.save(userquestion);
		}

		return R.ok();
	}
	
	@SysLog("根据题目类型选题")
	@RequestMapping("/addBatchByGrade")
	@RequiresPermissions("sys:userquestion:addBatchByGrade")
	public R addBatchByGrade(@RequestParam Map<String, Object> params) {
		String testsName = (String) params.get("testsName");
		String grade = (String) params.get("grade");

		QueryWrapper<TestsNameEntity> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("tests_name", testsName);
		TestsNameEntity testsNameEntity = testsNameService.getOne(queryWrapper);

		QueryWrapper<QuestionsEntity> secondQueryWrapper = new QueryWrapper<>();
		secondQueryWrapper.eq("grade", grade);
		List<QuestionsEntity> questionsEntities = questionsService.list(secondQueryWrapper);

		if (questionsEntities != null) {
			for (QuestionsEntity questionsEntity : questionsEntities) {

				UserquestionEntity userquestion = new UserquestionEntity();
				userquestion.setQuestionsId(questionsEntity.getQuestionsId());
				if (testsNameEntity != null) {
					userquestion.setTestsId(testsNameEntity.getTestsId());
				}

				userquestionService.save(userquestion);
			}
		}

		return R.ok();
	}
	@SysLog("随机选题")
	@RequestMapping("/addBatchByRandom")
	@RequiresPermissions("sys:userquestion:addBatchByRandom")
	public R addBatchByRandom(@RequestParam Map<String, Object> params) {
		String questionsNum = (String) params.get("questionsNum");
		int questionsNumLong =	(int)Long.parseLong(questionsNum);
		int[] questionsIdList = new int[questionsNumLong];

		TestsNameEntity testsNameEntity = new TestsNameEntity();
		testsNameEntity.setTestsName("随机测试" + questionsNum +"题");
		testsNameService.save(testsNameEntity);
		
		int total = questionsService.count();
		
		for (var i=0;i<questionsIdList.length;i++) {
			questionsIdList[i] = ((int)(Math.random()*total));
		}
		for (int questionsId : questionsIdList) {
			
			long questionsIdLong = (long) questionsId;
			UserquestionEntity userquestion = new UserquestionEntity();
			userquestion.setQuestionsId(questionsIdLong);
			userquestion.setTestsId(testsNameEntity.getTestsId());
			userquestionService.save(userquestion);
		}

		return R.ok();
	}
}
