package io.sipai.modules.sys.service.impl;

import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysUserEntity;
import io.sipai.modules.sys.entity.TestsEntity;

import org.apache.shiro.SecurityUtils;
import org.omg.CORBA.PRIVATE_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.awt.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mchange.lang.LongUtils;
import org.apache.commons.lang.StringUtils;

import io.sipai.common.utils.Constant;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;
import io.sipai.modules.sys.dao.UseranswerDao;
import io.sipai.modules.sys.entity.UseranswerEntity;
import io.sipai.modules.sys.service.QuestionsService;
import io.sipai.modules.sys.service.SysUserService;
import io.sipai.modules.sys.service.TestsService;
import io.sipai.modules.sys.service.UseranswerService;

@Service("useranswerService")
public class UseranswerServiceImpl extends ServiceImpl<UseranswerDao, UseranswerEntity> implements UseranswerService {

	@Autowired
	private QuestionsService questionsService;
	@Autowired
	private TestsService testsService;
	@Autowired
	SysUserService sysUserService;

	@Override
	public PageUtils queryPage(Map<String, Object> params) {
		String username = (String) params.get("username");
		Long userId = null;
		ArrayList<Long> usertestsId = new ArrayList<>();
		usertestsId.add(0L);
		IPage<UseranswerEntity> page = null;
		java.util.List<TestsEntity> tests = null;

		if (username != null) {
			QueryWrapper<SysUserEntity> queryWrapper = new QueryWrapper<>();
			queryWrapper.eq("username", username);
			SysUserEntity user = sysUserService.getOne(queryWrapper);

			if (user != null) {
				userId = user.getUserId();
				QueryWrapper<TestsEntity> queryWrapper2 = new QueryWrapper<>();
				queryWrapper2.eq("user_id", userId);
				tests = testsService.list(queryWrapper2);

				if (tests != null) {
					for (TestsEntity test : tests) {
						usertestsId.add(test.getId());
					}
				}

			}
			if (usertestsId != null) {
			page = this.page(new Query<UseranswerEntity>().getPage(params),
					new QueryWrapper<UseranswerEntity>().in( "usertests_id", usertestsId)
							.apply(params.get(Constant.SQL_FILTER) != null, (String) params.get(Constant.SQL_FILTER)));}

		} else if (username == null) {
			page = this.page(new Query<UseranswerEntity>().getPage(params), new QueryWrapper<UseranswerEntity>()
					.apply(params.get(Constant.SQL_FILTER) != null, (String) params.get(Constant.SQL_FILTER)));
		}

		for (UseranswerEntity useranswer : page.getRecords()) {

			TestsEntity testsEntity = testsService.getById(useranswer.getUsertestsId());
			if (testsEntity != null) {
				SysUserEntity sysUserEntity = sysUserService.getById(testsEntity.getUserId());
				if (sysUserEntity != null) {
					useranswer.setUsername(sysUserEntity.getUsername());
				}
			}
			QuestionsEntity question = questionsService.getById(useranswer.getQuestionsId());
			if (question != null) {
				useranswer.setQuestion(question.getQuestion());
				useranswer.setOption1(question.getOption1());
				useranswer.setOption2(question.getOption2());
				useranswer.setOption3(question.getOption3());
				useranswer.setOption4(question.getOption4());
			}

		}

		return new PageUtils(page);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveUseranswer(UseranswerEntity useranswer) {

		this.save(useranswer);
		questionsService.saveOrUpdate(useranswer.getQuestionsId(), useranswer.getQuestion(), useranswer.getOption1(),
				useranswer.getOption2(), useranswer.getOption3(), useranswer.getOption4());

	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void update(UseranswerEntity useranswer) {

		questionsService.saveOrUpdate(useranswer.getQuestionsId(), useranswer.getQuestion(), useranswer.getOption1(),
				useranswer.getOption2(), useranswer.getOption3(), useranswer.getOption4());

		useranswer.setQuestionsId(useranswer.getQuestionsId());

		useranswer.setAnsNumber(useranswer.getAnsNumber());
		useranswer.setAnsTime(useranswer.getAnsTime());

		this.updateById(useranswer);

	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteBatch(Long[] answerIds) {
		this.removeByIds(Arrays.asList(answerIds));

	}

}
