package io.sipai.modules.sys.service.impl;

import io.sipai.modules.sys.entity.AnswersEntity;
import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysDeptEntity;
import io.sipai.modules.sys.entity.SysRoleEntity;
import io.sipai.modules.sys.entity.SysUserEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.UseranswerEntity;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.aspectj.weaver.ast.And;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Console;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.druid.sql.visitor.functions.Isnull;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.injector.methods.DeleteById;
import com.baomidou.mybatisplus.core.injector.methods.SelectOne;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import io.sipai.common.utils.Constant;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;

import io.sipai.modules.sys.dao.UserquestionDao;
import io.sipai.modules.sys.entity.UserquestionEntity;
import io.sipai.modules.sys.service.AnswersService;
import io.sipai.modules.sys.service.QuestionsService;
import io.sipai.modules.sys.service.SysUserService;
import io.sipai.modules.sys.service.TestsService;
import io.sipai.modules.sys.service.UserquestionService;

@Service("userquestionService")
public class UserquestionServiceImpl extends ServiceImpl<UserquestionDao, UserquestionEntity>
		implements UserquestionService {

	@Autowired
	private QuestionsService questionsService;

	@Autowired
	private UserquestionService userquestionService;

	@Autowired
	private SysUserService sysUserService;

	@Autowired
	private TestsService testsService;

	@Autowired
	private AnswersService answersService;

	@Override
	public PageUtils queryPage(Map<String, Object> params) {
		String username = (String) params.get("username");
		Long userId = null;
		ArrayList<Long> testsId = new ArrayList<>();
		testsId.add(0L);
		IPage<UserquestionEntity> page = null;
		String usernameString = "";

		if (username != null) {
			QueryWrapper<SysUserEntity> queryWrapper = new QueryWrapper<>();
			queryWrapper.eq("username", username);
			SysUserEntity user = sysUserService.getOne(queryWrapper);

			if (user != null) {
				userId = user.getUserId();
				QueryWrapper<TestsEntity> queryWrapper2 = new QueryWrapper<>();
				queryWrapper2.eq("user_id", userId);
				java.util.List<TestsEntity> tests = testsService.list(queryWrapper2);
				if (tests != null) {
					for (TestsEntity test : tests) {
						testsId.add(test.getTestsId());
					}
				}

			}

			page = this.page(new Query<UserquestionEntity>().getPage(params),
					new QueryWrapper<UserquestionEntity>().in(testsId!=null,"tests_id", testsId).orderByAsc("questions_id").groupBy("questions_id")
							.apply(params.get(Constant.SQL_FILTER) != null, (String) params.get(Constant.SQL_FILTER)));

		}

		else if (username == null) {
			page = this.page(new Query<UserquestionEntity>().getPage(params), new QueryWrapper<UserquestionEntity>().orderByAsc("questions_id").groupBy("questions_id")
					.apply(params.get(Constant.SQL_FILTER) != null, (String) params.get(Constant.SQL_FILTER)));

		}

		for (UserquestionEntity userquestionEntity : page.getRecords()) {
			QuestionsEntity questionsEntity = questionsService.getById(userquestionEntity.getQuestionsId());

			QueryWrapper<TestsEntity> queryWrapper = new QueryWrapper<>();
			queryWrapper.eq("tests_id", userquestionEntity.getTestsId());
			List<TestsEntity> tests = testsService.list(queryWrapper);
			if (questionsEntity != null) {
				userquestionEntity.setQuestion(questionsEntity.getQuestion());
			}
			if (tests != null) {
				for (TestsEntity test : tests) {
					SysUserEntity sysUserEntity = sysUserService.getById(test.getUserId());
					if (sysUserEntity != null) {
						usernameString += sysUserEntity.getUsername() + ",";
					}
				}

			}
			userquestionEntity.setUsername(usernameString);

		}

		return new PageUtils(page);

	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveUserquestion(UserquestionEntity userquestion) {

		QueryWrapper<QuestionsEntity> firstqueryWrapper = new QueryWrapper<>();
		firstqueryWrapper.eq("question", userquestion.getQuestion());
		QuestionsEntity questionsEntity = questionsService.getOne(firstqueryWrapper);

		userquestion.setQuestionsId(questionsEntity.getQuestionsId());
		userquestion.setTestsId(userquestion.getTestsId());
		this.save(userquestion);

	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void update(UserquestionEntity userquestion) {

		QueryWrapper<QuestionsEntity> firstqueryWrapper = new QueryWrapper<>();
		firstqueryWrapper.eq("question", userquestion.getQuestion());
		QuestionsEntity questionsEntity = questionsService.getOne(firstqueryWrapper);

		QueryWrapper<SysUserEntity> secondqueryWrapper = new QueryWrapper<>();
		secondqueryWrapper.eq("username", userquestion.getUsername());
		SysUserEntity sysUserEntity = sysUserService.getOne(secondqueryWrapper);

		userquestion.setQuestionsId(questionsEntity.getQuestionsId());
		userquestion.setTestsId(userquestion.getTestsId());
		this.updateById(userquestion);

		TestsEntity testsEntity = testsService.getById(userquestion.getTestsId());
		if (testsEntity != null) {
			testsEntity.setTestStatus(0L);
			testsEntity.setUserId(sysUserEntity.getUserId());
			testsService.saveOrUpdate(testsEntity);
		}

	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteBatch(Long[] userquestions) {
		
		this.removeByIds(Arrays.asList(userquestions));
	}

	@Override
	public List<QuestionsEntity> queryList(Map<String, Object> params) {
		return baseMapper.queryList(params);
	}

}
