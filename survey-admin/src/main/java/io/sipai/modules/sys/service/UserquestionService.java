package io.sipai.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysDeptEntity;
import io.sipai.modules.sys.entity.SysRoleEntity;
import io.sipai.modules.sys.entity.UseranswerEntity;
import io.sipai.modules.sys.entity.UserquestionEntity;

import java.util.List;
import java.util.Map;

/**
 * 用户答题
 *
 * @author Leo
 */
public interface UserquestionService extends IService<UserquestionEntity> {

	PageUtils queryPage(Map<String, Object> params);

	void saveUserquestion(UserquestionEntity userquestion);

	void update(UserquestionEntity userquestion);
	
	void deleteBatch(Long[] userquestions);
		
	List<QuestionsEntity> queryList(Map<String, Object> map);
	
    
    
}

