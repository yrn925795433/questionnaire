package io.sipai.modules.sys.service.impl;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;
import io.sipai.modules.sys.dao.TestsNameDao;
import io.sipai.modules.sys.entity.AnswersEntity;
import io.sipai.modules.sys.entity.TestsNameEntity;
import io.sipai.modules.sys.service.TestsNameService;

@Service("testsNameService")
public class TestsNameServiceImpl extends ServiceImpl<TestsNameDao,TestsNameEntity> implements TestsNameService{

	@Override
	public PageUtils queryPage(Map<String, Object> params) {
        IPage<TestsNameEntity> page = this.page(
                new Query<TestsNameEntity>().getPage(params),
                new QueryWrapper<TestsNameEntity>()
        );
        return new PageUtils(page);
        
	}

	
}
