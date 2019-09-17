package io.sipai.modules.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.user.entity.QuestionsEntity;

import java.util.Map;

/**
 * 题库管理
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
public interface QuestionsService extends IService<QuestionsEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

