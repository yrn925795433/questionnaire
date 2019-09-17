package io.sipai.modules.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import io.sipai.common.utils.PageUtils;
import io.sipai.common.utils.Query;
import io.sipai.modules.user.dao.QuestionsDao;
import io.sipai.modules.user.entity.QuestionsEntity;
import io.sipai.modules.user.service.QuestionsService;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("questionsService")
public class QuestionsServiceImpl extends ServiceImpl<QuestionsDao, QuestionsEntity> implements QuestionsService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<QuestionsEntity> page = this.page(
                new Query<QuestionsEntity>().getPage(params),
                new QueryWrapper<QuestionsEntity>()
        );

        return new PageUtils(page);
    }

}
