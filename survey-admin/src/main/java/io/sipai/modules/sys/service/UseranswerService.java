package io.sipai.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.sys.entity.UseranswerEntity;

import java.util.Map;

/**
 * 用户答题
 *
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
public interface UseranswerService extends IService<UseranswerEntity> {

	PageUtils queryPage(Map<String, Object> params);
   
	
    void saveUseranswer(UseranswerEntity useranswer);

    void update(UseranswerEntity useranswer);
    
    void deleteBatch(Long[] answerIds);
}

