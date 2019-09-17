package io.sipai.modules.user.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 测试管理
 * @date 2019-05-29 16:27:20
 */
@Data
@TableName("usertests")
public class TestsEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 测试ID
	 */
	@TableId(type=IdType.AUTO)
	private Long id;
	
	private Long testsId;
	
	private Long userId;
	
	private Long testStatus;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private String testTime;
	
	@TableField(exist=false)
	private String testsName;

	@TableField(exist=false)
	private String username;
}
