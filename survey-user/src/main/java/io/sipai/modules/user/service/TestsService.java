package io.sipai.modules.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.user.entity.TestsEntity;

import java.util.Map;

/**
 * 测试管理
 * @date 2019-05-29 16:27:20
 */
public interface TestsService extends IService<TestsEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

