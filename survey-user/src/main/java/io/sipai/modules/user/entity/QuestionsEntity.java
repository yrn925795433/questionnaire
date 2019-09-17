package io.sipai.modules.user.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 题库管理
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@Data
@TableName("questions")
public class QuestionsEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 题目ID
	 */
	@TableId
	private Long questionsId;
	/**
	 * 等级
	 */
	private String grade;
	/**
	 * 分类
	 */
	private String mainclass;
	/**
	 * 子域名称
	 */
	private String subclass;
	/**
	 * 子域权重
	 */
	private BigDecimal subweight;
	/**
	 * 题目名称
	 */
	private String question;
	/**
	 * 题目权重
	 */
	private BigDecimal quweight;
	/**
	 * 答案1
	 */
	private String option1;
	/**
	 * 答案2
	 */
	private String option2;
	/**
	 * 答案3
	 */
	private String option3;
	/**
	 * 答案4
	 */
	private String option4;

}
