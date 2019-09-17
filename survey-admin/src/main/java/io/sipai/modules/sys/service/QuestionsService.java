package io.sipai.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysDeptEntity;

import java.util.HashMap;
import java.util.List;
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
        
    void saveOrUpdate(Long questionsId, String question, String option1, String option2, String option3,String option4);
    
	QuestionsEntity queryQuestion(Long questionsId) ;
    
	int deleteBatch(Long[] questionsIds);
	
	List<Long> queryQuestionIdList(Long id);
	
	List<QuestionsEntity> queryList(Map<String, Object> map);
	
	PageUtils queryAllQuestions(Map<String, Object> params);
	
	List<QuestionsEntity> queryListByGrade(Map<String, Object> map);

	
	
	
}

