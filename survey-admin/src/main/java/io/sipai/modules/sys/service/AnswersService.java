package io.sipai.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.sys.entity.AnswersEntity;

import java.util.Map;

/**
 * 答题管理
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
public interface AnswersService extends IService<AnswersEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

