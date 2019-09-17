package io.sipai.modules.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.user.entity.AnswersEntity;

import java.util.List;
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

    boolean submitAnswers(List<Map<String, Object>> params);

    List<Map<String, Object>> getQuestionsByUserId(Map<String, Object> map);

    void insertAnswers(Long testsId);
}

