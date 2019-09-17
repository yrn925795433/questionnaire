package io.sipai.modules.sys.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Console;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;

import io.sipai.modules.sys.dao.TestsDao;
import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysUserEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.TestsNameEntity;
import io.sipai.modules.sys.entity.UserquestionEntity;
import io.sipai.modules.sys.service.SysUserService;
import io.sipai.modules.sys.service.TestsNameService;
import io.sipai.modules.sys.service.TestsService;

@Service("testsService")
public class TestsServiceImpl extends ServiceImpl<TestsDao, TestsEntity> implements TestsService {

	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private TestsService testsService;
	@Autowired
	private TestsNameService testsNameService;

	@Override
	public PageUtils queryPage(Map<String, Object> params) {

		String testsName = (String) params.get("testsName");
		TestsNameEntity testsNameE = new TestsNameEntity();
		Long testsId = null;
		IPage<TestsEntity> page = null;

		if (testsName != null) {
			QueryWrapper<TestsNameEntity> queryWrapper = new QueryWrapper<>();
			queryWrapper.eq("tests_name", testsName);
			testsNameE = testsNameService.getOne(queryWrapper);

			if (testsNameE != null) {
				testsId = testsNameE.getTestsId();
			}

			page = this.page(new Query<TestsEntity>().getPage(params), new QueryWrapper<TestsEntity>()
					.eq(StringUtils.isNotBlank(Long.toString(testsId)), "tests_id", testsId));
		}

		else if (testsName == null) {
			page = this.page(new Query<TestsEntity>().getPage(params), new QueryWrapper<TestsEntity>());

		} 

		for (TestsEntity testsEntity : page.getRecords()) {
			TestsNameEntity testsNameEntity = testsNameService.getById(testsEntity.getTestsId());
			if (testsNameEntity != null) {
				testsEntity.setTestsName(testsNameEntity.getTestsName());
			}
			SysUserEntity sysUserEntity = sysUserService.getById(testsEntity.getUserId());
			if (sysUserEntity != null) {
				testsEntity.setUsername(sysUserEntity.getUsername());
			}
		}

		return new PageUtils(page);
	}

	@Override
	public void update(TestsEntity testsEntity) {
		QueryWrapper<SysUserEntity> secondqueryWrapper = new QueryWrapper<>();
		secondqueryWrapper.eq("username", testsEntity.getUsername());
		SysUserEntity sysUserEntity = sysUserService.getOne(secondqueryWrapper);

		testsEntity.setUserId(sysUserEntity.getUserId());
		this.updateById(testsEntity);

	}

	@Override
	public void saveTests(TestsEntity testsEntity) {
		QueryWrapper<SysUserEntity> secondqueryWrapper = new QueryWrapper<>();
		secondqueryWrapper.eq("username", testsEntity.getUsername());
		SysUserEntity sysUserEntity = sysUserService.getOne(secondqueryWrapper);

		testsEntity.setUserId(sysUserEntity.getUserId());
		this.save(testsEntity);

	}

	@Override
	public List<TestsEntity> queryList(Map<String, Object> params) {
		QueryWrapper<TestsEntity> queryWrapper = new QueryWrapper<>();
		queryWrapper.groupBy("tests_id").orderByAsc("tests_id");
		return testsService.list(queryWrapper);
	}

}
