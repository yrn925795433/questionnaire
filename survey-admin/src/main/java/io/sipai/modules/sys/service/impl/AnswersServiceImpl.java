package io.sipai.modules.sys.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;

import io.sipai.modules.sys.dao.AnswersDao;
import io.sipai.modules.sys.entity.AnswersEntity;
import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.TestsNameEntity;
import io.sipai.modules.sys.entity.UserquestionEntity;
import io.sipai.modules.sys.service.AnswersService;
import io.sipai.modules.sys.service.QuestionsService;
import io.sipai.modules.sys.service.TestsNameService;
import io.sipai.modules.sys.service.TestsService;

@Service("answersService")
public class AnswersServiceImpl extends ServiceImpl<AnswersDao, AnswersEntity> implements AnswersService {

	@Autowired
	private QuestionsService questionsService;

	@Autowired
	private TestsNameService testsNameService;

	@Override
	public PageUtils queryPage(Map<String, Object> params) {

		String testsName = (String) params.get("testsName");
		TestsNameEntity testsNameE = new TestsNameEntity();
		Long testsId = null;
		IPage<AnswersEntity> page = null;

		if (testsName != null) {
		QueryWrapper<TestsNameEntity> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("tests_name", testsName);
		testsNameE = testsNameService.getOne(queryWrapper);
		if (testsNameE != null) {
			testsId = testsNameE.getTestsId();
		}

		page = (IPage<AnswersEntity>) this.page(new Query<AnswersEntity>().getPage(params),
				new QueryWrapper<AnswersEntity>().eq(StringUtils.isNotBlank(Long.toString(testsId)), "tests_id", testsId).orderByAsc("tests_id"));
		}
		else if (testsName == null) {
			page = this.page(new Query<AnswersEntity>().getPage(params),
					new QueryWrapper<AnswersEntity>().orderByAsc("tests_id"));
		}

		for (AnswersEntity answer : page.getRecords()) {
			QueryWrapper<QuestionsEntity> firstQueryWrapper = new QueryWrapper<>();
			firstQueryWrapper.eq("questions_id", answer.getQuestionsId());
			QuestionsEntity questionsEntity = questionsService.getOne(firstQueryWrapper);
			if (questionsEntity != null) {
				answer.setQuestion(questionsEntity.getQuestion());
			}
			QueryWrapper<TestsNameEntity> secondQueryWrapper = new QueryWrapper<>();
			secondQueryWrapper.eq("tests_id", answer.getTestsId());
			TestsNameEntity testsEntity = testsNameService.getOne(secondQueryWrapper);
			if (testsEntity != null) {
				answer.setTestsName(testsEntity.getTestsName());
			} else {
				continue;
			}
		}

		return new PageUtils(page);
	}

}
