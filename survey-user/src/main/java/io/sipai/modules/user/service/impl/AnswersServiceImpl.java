package io.sipai.modules.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;
import io.sipai.modules.user.dao.AnswersDao;
import io.sipai.modules.user.entity.AnswersEntity;
import io.sipai.modules.user.entity.QuestionsEntity;
import io.sipai.modules.user.entity.TestsEntity;
import io.sipai.modules.user.service.AnswersService;
import io.sipai.modules.user.service.QuestionsService;
import io.sipai.modules.user.service.TestsService;

import org.postgresql.translation.messages_bg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service("answersService")
public class AnswersServiceImpl extends ServiceImpl<AnswersDao, AnswersEntity> implements AnswersService {

	@Autowired
	private TestsService testsService;
	@Autowired
	private QuestionsService questionsService;
	@Autowired
	private AnswersService answersService;

	@Override
	public PageUtils queryPage(Map<String, Object> params) {
		IPage<AnswersEntity> page = this.page(new Query<AnswersEntity>().getPage(params),
				new QueryWrapper<AnswersEntity>());

		return new PageUtils(page);
	}

	@Override
	public boolean submitAnswers(List<Map<String, Object>> params) {
		for (Map<String, Object> m : params) {
			QueryWrapper<TestsEntity> queryWrapper = new QueryWrapper<TestsEntity>();
			queryWrapper.eq("tests_id", Long.parseLong(m.get("testId").toString()))
					.eq("user_id", Long.parseLong(m.get("userId").toString())).eq("test_status", 0L);
			TestsEntity testsEntity = testsService.getOne(queryWrapper);

			AnswersEntity entity = new AnswersEntity();

			QueryWrapper<AnswersEntity> secondQueryWrapper = new QueryWrapper<>();
			secondQueryWrapper.eq("usertests_id", testsEntity.getId()).eq("questions_id",
					Long.parseLong(m.get("questionsId").toString()));
			entity = answersService.getOne(secondQueryWrapper);

			if (entity == null) {
				entity = new AnswersEntity();
			}
			entity.setUsertestsId(testsEntity.getId());
			entity.setTestsId(testsEntity.getTestsId());
			entity.setUserId(testsEntity.getUserId());
			entity.setQuestionsId(Long.parseLong(m.get("questionsId").toString()));
			entity.setAnsNumber(Long.parseLong(m.get("answerNumber").toString()));

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			entity.setAnsTime(sdf.format(new Date()));

			this.saveOrUpdate(entity);

		}
		Map<String, Object> model = params.get(0);
		QueryWrapper<TestsEntity> queryWrapper = new QueryWrapper<TestsEntity>();
		queryWrapper.eq("tests_id", Long.parseLong(model.get("testId").toString()))
				.eq("user_id", Long.parseLong(model.get("userId").toString())).eq("test_status", 0L);
		TestsEntity testsEntity = testsService.getOne(queryWrapper);
		testsEntity.setTestStatus(1L);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		testsEntity.setTestTime(sdf.format(new Date()));
		testsService.updateById(testsEntity);

		return true;
	}

	@Override
	public List<Map<String, Object>> getQuestionsByUserId(Map<String, Object> map) {
		return baseMapper.getQuestionsByUserId(map);
	}

	@Override
	public void insertAnswers(Long testsId) {
		baseMapper.insertAnswers(testsId);
	}

}
