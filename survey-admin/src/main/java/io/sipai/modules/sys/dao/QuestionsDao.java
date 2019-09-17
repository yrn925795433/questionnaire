package io.sipai.modules.sys.dao;

import io.sipai.modules.sys.entity.QuestionsEntity;
import io.sipai.modules.sys.entity.SysDeptEntity;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

/**
 * 题库管理
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@Mapper
public interface QuestionsDao extends BaseMapper<QuestionsEntity> {	
	int deleteBatch(Long[] roleIds);
	
	QuestionsEntity queryQuestion(Long questionsId);
	
	List<Long> queryQuestionIdList(Long id);
	List<QuestionsEntity> queryList(Map<String, Object> map);

	
}
