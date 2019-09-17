
package io.sipai.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.sipai.common.utils.PageUtils;
import io.sipai.modules.sys.entity.SysDictEntity;

import java.util.Map;

/**
 * 数据字典
 *
 * @author Mark sunlightcs@gmail.com
 */
public interface SysDictService extends IService<SysDictEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

