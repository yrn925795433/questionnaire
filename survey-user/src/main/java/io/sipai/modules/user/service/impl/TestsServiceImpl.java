package io.sipai.modules.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;
import io.sipai.modules.user.dao.TestsDao;
import io.sipai.modules.user.entity.TestsEntity;
import io.sipai.modules.user.service.TestsService;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("testsService")
public class TestsServiceImpl extends ServiceImpl<TestsDao, TestsEntity> implements TestsService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<TestsEntity> page = this.page(
                new Query<TestsEntity>().getPage(params),
                new QueryWrapper<TestsEntity>()
        );

        return new PageUtils(page);
    }

}
