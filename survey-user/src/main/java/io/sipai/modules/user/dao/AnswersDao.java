package io.sipai.modules.user.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import io.sipai.modules.user.entity.AnswersEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * 答题管理
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@Mapper
public interface AnswersDao extends BaseMapper<AnswersEntity> {

    List<Map<String, Object>> getQuestionsByUserId(Map<String, Object> map);

    void insertAnswers(Long testsId);
}
