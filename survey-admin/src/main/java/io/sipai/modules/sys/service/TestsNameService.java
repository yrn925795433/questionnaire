package io.sipai.modules.sys.service;

import java.util.Map;

import com.baomidou.mybatisplus.extension.service.IService;

import io.sipai.common.utils.PageUtils;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.TestsNameEntity;

public interface TestsNameService  extends IService<TestsNameEntity>{
	
    PageUtils queryPage(Map<String, Object> params);

}
