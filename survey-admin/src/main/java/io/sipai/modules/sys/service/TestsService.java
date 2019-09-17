package io.sipai.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.TestsEntity;
import io.sipai.modules.sys.entity.UserquestionEntity;

import java.util.List;
import java.util.Map;

/**
 * 测试管理
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
public interface TestsService extends IService<TestsEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
	void update(TestsEntity testsEntity);
	
	void saveTests(TestsEntity testsEntity);
	
	List<TestsEntity> queryList(Map<String, Object> map);


}

