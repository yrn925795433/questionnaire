
package io.sipai.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import io.sipai.modules.sys.entity.SysRoleEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 角色管理
 */
@Mapper
public interface SysRoleDao extends BaseMapper<SysRoleEntity> {
	

}
